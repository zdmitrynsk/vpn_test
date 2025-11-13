import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_test/features/vpn_list/bloc/data_vpns_bloc.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/add_vpn_button_list_item.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/empty_message_list_item.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/search_field_list_item.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/subtitle_vpn_list_item.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/vpn_list_item.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/vpn_list_item_interface.dart';
import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/vpns_list.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/ui/widgets/add_vpn_button.dart';
import 'package:vpn_test/ui/widgets/cars_vpn_list/card_vpn_list.dart';
import 'package:vpn_test/ui/widgets/cars_vpn_list/subtitle_vpn_list.dart';
import 'package:vpn_test/ui/widgets/empty_message.dart';
import 'package:vpn_test/ui/widgets/search_field.dart';

@RoutePage()
class AllVpnsScreen extends StatefulWidget {
  const AllVpnsScreen({super.key});

  @override
  State<AllVpnsScreen> createState() => _AllVpnsScreenState();
}

class _AllVpnsScreenState extends State<AllVpnsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final DataVpnsBloc _loadVpnsBloc = DataVpnsBloc();
  final FilterVpnType _filter = FilterVpnType.all;
  TabsRouter? _tabsRouter;

  static const int _routeTabIndex = 0;

  @override
  void initState() {
    _initSearchController();
    _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabsRouter();
  }
  

  @override
  void dispose() {
    _searchController.removeListener(_onEventSearch);
    _tabsRouter?.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _loadVpnsBloc,
        builder: (context, state) {
          if (state is LoadedDataVpnsState) {
            return _loadedDataVpnsState(state);
          } else if (state is EmptySearchDataVpnsState) {
            return _emptySearchDataState();
          }
          return Container();
        });
  }

  void _updateTabsRouter() {
    final tr = AutoTabsRouter.of(context);
    if (_tabsRouter != tr) {
      _tabsRouter?.removeListener(_onTabChanged);
      _tabsRouter = tr;
      _tabsRouter?.addListener(_onTabChanged);
    }
  }

  void _onTabChanged() {
    if (_tabsRouter?.activeIndex == _routeTabIndex) {
      _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
    }
  }

  void _initSearchController() {
    _searchController.addListener(_onEventSearch);
  }

  void _onEventSearch() {
    _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
  }

  ListView _loadedDataVpnsState(LoadedDataVpnsState state) {
    VpnsCardsList cards = _defaultCards();
    cards.items
        .addAll(VpnsCardsList.fromVpnsInfoList(state.vpnsList, true).items);
    return ListView.builder(
        itemCount: cards.items.length,
        itemBuilder: (context, index) => _buildItem(index, cards));
  }

  ListView _emptySearchDataState() {
    return ListView.builder(
        itemCount: _emptyCardsMessage().items.length,
        itemBuilder: (context, index) =>
            _buildItem(index, _emptyCardsMessage()));
  }

  VpnsCardsList _emptyCardsMessage() {
    VpnsCardsList cardsList = VpnsCardsList();
    cardsList.addItem(SearchFieldListItem());
    cardsList.addItem(MessageListItem("Нет результатов",
        "По вашему запросу серверов\nне найдено. Попробуйте изменить\nзапрос или проверьте написание"));
    return cardsList;
  }

  VpnsCardsList _defaultCards() {
    VpnsCardsList baseCardsList = VpnsCardsList();
    baseCardsList.addItem(SearchFieldListItem());
    baseCardsList.addItem(SubtitleVpnListItem(subtitle: 'Мои точки доступа'));
    baseCardsList.addItem(AddVpnButtonListItem());
    return baseCardsList;
  }

  _buildItem(int index, VpnsCardsList vpnsList) {
    VpnListItemInterface item = vpnsList.items[index];
    if (item is SubtitleVpnListItem) {
      return SubtitleVpnList(
          text: (item).subtitle);
    } else if (item is VpnListItem) {
      return CardVpnList(
        id: item.id,
        city: item.city,
        ping: item.ping,
        isActive: item.isActive,
        isFavorite: item.isFavorite,
        countryCode: item.countryCode,
        onLikeTap: () {
          _loadVpnsBloc.add(TogleFavoriteDataVpnsEvent(id: item.id));
        },
      );
    } else if (item is SearchFieldListItem) {
      return SearchField(_searchController);
    } else if (item is AddVpnButtonListItem) {
      return AddVpnButton();
    } else if (item is MessageListItem) {
      return Message("Нет результатов",
          "По вашему запросы серверов\nне найдено. Попробуйте изменить\nзапрос или проверьте написание");
    }
    return Container();
  }
}
