import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_test/features/data_vpns/bloc/data_vpns_bloc.dart';
import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/add_vpn_button_list_item.dart';
import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/empty_message_list_item.dart';
import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/search_field_list_item.dart';
import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/subtitle_vpn_list_item.dart';
import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/vpn_list_item.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpns_list.dart';
import 'package:vpn_test/ui/widgets/add_vpn_button.dart';
import 'package:vpn_test/ui/widgets/empty_message.dart';
import 'package:vpn_test/ui/widgets/search_field.dart';
import 'package:vpn_test/ui/widgets/vpns_list/card_vpn_list.dart';
import 'package:vpn_test/ui/widgets/vpns_list/subtitle_vpn_list.dart';

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
    final tr = AutoTabsRouter.of(context);
    if (_tabsRouter != tr) {
      _tabsRouter?.removeListener(_onTabChanged);
      _tabsRouter = tr;
      _tabsRouter?.addListener(_onTabChanged);
    }
  }

  void _initSearchController() {
    _searchController.addListener(_onEventSearch);
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
            return _loadedState(state);
          } else if (state is EmptySearchDataVpnsState) {
            return _vpnsEmptyState();
          }
          return Container();
        });
  }

  ListView _loadedState(LoadedDataVpnsState state) {
    VpnsCardsList cards = defaultCards();
    cards.items
        .addAll(VpnsCardsList.fromVpnsInfoList(state.vpnsList, true).items);
    return ListView.builder(
        itemCount: cards.items.length,
        itemBuilder: (context, index) => _buildItem(index, cards));
  }

  ListView _vpnsEmptyState() {
    return ListView.builder(
        itemCount: emptyCardsMessage().items.length,
        itemBuilder: (context, index) =>
            _buildItem(index, emptyCardsMessage()));
  }

  VpnsCardsList emptyCardsMessage() {
    VpnsCardsList cardsList = VpnsCardsList();
    cardsList.addItem(SearchFieldListItem());
    cardsList.addItem(MessageListItem("Нет результатов",
        "По вашему запросу серверов\nне найдено. Попробуйте изменить\nзапрос или проверьте написание"));
    return cardsList;
  }

  VpnsCardsList defaultCards() {
    VpnsCardsList baseCardsList = VpnsCardsList();
    baseCardsList.addItem(SearchFieldListItem());
    baseCardsList.addItem(SubtitleVpnListItem(subtitle: 'Мои точки доступа'));
    baseCardsList.addItem(AddVpnButtonListItem());
    return baseCardsList;
  }

  void _onEventSearch() {
    _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
  }

  void _onTabChanged() {
    if (_tabsRouter?.activeIndex == _routeTabIndex) {
      _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
    }
  }

  _buildItem(int index, VpnsCardsList vpnsList) {
    Theme.of(context);
    switch (vpnsList.items[index]) {
      case SubtitleVpnListItem():
        return SubtitleVpnList(
            text: (vpnsList.items[index] as SubtitleVpnListItem).subtitle);
      case VpnListItem():
        var vpn = (vpnsList.items[index] as VpnListItem);
        return CardVpnList(
          id: vpn.id,
          city: vpn.city,
          ping: vpn.ping,
          isActive: vpn.isActive,
          isFavorite: vpn.isFavorite,
          countryCode: vpn.countryCode,
          onLikeTap: () {
            _loadVpnsBloc.add(TogleFavoriteDataVpnsEvent(id: vpn.id));
          },
        );
      case SearchFieldListItem():
        return SearchField(_searchController);
      case AddVpnButtonListItem():
        return AddVpnButton();
      case MessageListItem():
        return Message("Нет результатов",
            "По вашему запросы серверов\nне найдено. Попробуйте изменить\nзапрос или проверьте написание");
    }
  }
}
