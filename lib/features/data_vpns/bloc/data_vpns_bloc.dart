import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/vpns_catalog_repository_i.dart';

part 'data_vpns_event.dart';
part 'data_vpns_state.dart';

class DataVpnsBloc extends Bloc<DataVpnsEvent, DataVpnsState> {
  late VpnCatalogRepositoryI _vpnInfoRepository;
  late FilterVpnType _lastFilterType;

  String _lastSearchText = '';
  List<VpnInfo> _vpnList = [];

  void _setDependencies() {
    GetIt di = GetIt.I;
    _vpnInfoRepository = di<VpnCatalogRepositoryI>();
  }

  DataVpnsBloc() : super(InitialDataVpnsState()) {
    _setDependencies();

    on<SearchDataVpnsEvent>((event, emit) {
      if (event.searchVpnsText == _lastSearchText &&
          event.searchVpnsText != '') {
        return;
      }
      _lastSearchText = event.searchVpnsText;
      _showVpns(event.filterType, event.searchVpnsText);
    });

    on<TogleFavoriteDataVpnsEvent>((event, emit) {
      _vpnInfoRepository.togleFavorite(event.id);
      _showVpns(_lastFilterType, _lastSearchText);
    });
  }

  void _showVpns(FilterVpnType filterType, String searchVpnsText) {
    _lastFilterType = filterType;
    _vpnList = _vpnInfoRepository.getVpnsInfo(filterType, searchVpnsText);
    if (_vpnList.isEmpty && searchVpnsText == '') {
      emit(EmptyInitialDataVpnsState());
      return;
    } else if (_vpnList.isEmpty) {
      emit(EmptySearchDataVpnsState());
      return;
    }
    emit(LoadedDataVpnsState(vpnsList: _vpnList));
  }
}
