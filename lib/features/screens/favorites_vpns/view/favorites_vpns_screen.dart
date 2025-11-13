import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_test/features/vpn_list/bloc/data_vpns_bloc.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/add_vpn_button_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/empty_message_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/search_field_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/subtitle_vpn_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/vpn_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpns_list.dart';
import 'package:vpn_test/ui/widgets/add_vpn_button.dart';
import 'package:vpn_test/ui/widgets/empty_message.dart';
import 'package:vpn_test/ui/widgets/search_field.dart';
import 'package:vpn_test/ui/widgets/cars_vpn_list/card_vpn_list.dart';
import 'package:vpn_test/ui/widgets/cars_vpn_list/subtitle_vpn_list.dart';

@RoutePage()
class FavoriteVpnsScreen extends StatefulWidget {
  const FavoriteVpnsScreen({super.key});

  @override
  State<FavoriteVpnsScreen> createState() => _FavoritesVpnsScreenState();
}

class _FavoritesVpnsScreenState extends State<FavoriteVpnsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final DataVpnsBloc _loadVpnsBloc = DataVpnsBloc();
  final FilterVpnType _filter = FilterVpnType.favorite;
  TabsRouter? _tabsRouter;

  static const int _routeTabIndex = 2;

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
            return _emptySearchDataVpnsState();
          } else if (state is EmptyInitialDataVpnsState) {
            return _emptyInitialDataVpnsState();
          }
          return Container();
        });
  }

  void _initSearchController() {
    _searchController.addListener(_onEventSearch);
  }

  void _onEventSearch() {
    _loadVpnsBloc.add(SearchDataVpnsEvent(_searchController.text, _filter));
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

  ListView _loadedDataVpnsState(LoadedDataVpnsState state) {
    VpnsCardsList cards = _defaultCards();
    cards.items
        .addAll(VpnsCardsList.fromVpnsInfoList(state.vpnsList, false).items);
    return ListView.builder(
        itemCount: cards.items.length,
        itemBuilder: (context, index) => _buildItem(index, cards));
  }

/*************  ✨ Windsurf Command ⭐  *************/
  /// Returns a base list of cards which always contains a search field list item.
  ///
  /// This list is used to display the search field when the user has not entered
  /// any search query and the list of VPNs is empty.
  ///
  /// The search field list item is the first item in the list.
/*******  c57f03d8-209a-4a51-8103-e380db0a4657  *******/
  VpnsCardsList _defaultCards() {
    VpnsCardsList baseCardsList = VpnsCardsList();
    baseCardsList.addItem(SearchFieldListItem());
    return baseCardsList;
  }

  ListView _emptySearchDataVpnsState() {
    var emptySearchMessageCards = _emptySearchMessageCards("Нет результатов",
        "По вашему запросу серверов\nне найдено. Попробуйте изменить\nзапрос или проверьте написание");
    return ListView.builder(
        itemCount: emptySearchMessageCards.items.length,
        itemBuilder: (context, index) =>
            _buildItem(index, emptySearchMessageCards));
  }

  VpnsCardsList _emptySearchMessageCards(String title, String text) {
    VpnsCardsList cardsList = VpnsCardsList();
    cardsList.addItem(SearchFieldListItem());
    cardsList.addItem(MessageListItem(title, text));
    return cardsList;
  }

  _emptyInitialDataVpnsState() {
    var emptySearchMessageCards = _emptySearchMessageCards(
        "Нет результатов", "Пока что здесь пусто.\nДобавьте VPN");
    return ListView.builder(
        itemCount: emptySearchMessageCards.items.length,
        itemBuilder: (context, index) =>
            _buildItem(index, emptySearchMessageCards));
  }

  _buildItem(int index, VpnsCardsList vpnsList) {
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
        MessageListItem message = vpnsList.items[index] as MessageListItem;
        return Message(message.title, message.message);
    }
  }
}
