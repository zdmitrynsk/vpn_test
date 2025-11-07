import 'package:vpn_test/repositories/vpn_catalog_repository/data/data.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/vpns_catalog_repository_i.dart';

class VpnCatalogRepository implements VpnCatalogRepositoryI {
  final List<VpnInfo> _list = vpnListData;

  @override
  List<VpnInfo> getVpnsInfo(FilterVpnType filter, String city) {
    List<VpnInfo> result = _filterByType(filter, _list);
    result = _filterByCity(city, result);
    return result;
  }

  @override
  void togleFavorite(int id) {
    _list[id].isFavorite = !_list[id].isFavorite;
  }

  List<VpnInfo> _filterByType(FilterVpnType? filter, List<VpnInfo> result) {
    switch (filter) {
      case FilterVpnType.favorite:
        result = result.where((v) => v.isFavorite).toList();
        break;
      case FilterVpnType.mine:
        result = result.where((v) => v.isMine).toList();
        break;
      case FilterVpnType.all:
      case null:
        break;
    }
    return result;
  }

  List<VpnInfo> _filterByCity(String searchText, List<VpnInfo> result) {
    final query = searchText.trim();
    if (query.isNotEmpty) {
      final lower = query.toLowerCase();
      result =
          result.where((v) => v.city.toLowerCase().contains(lower)).toList();
    }
    return result;
  }
}
