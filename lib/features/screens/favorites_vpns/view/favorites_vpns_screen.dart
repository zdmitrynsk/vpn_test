import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_test/features/data_vpns/bloc/data_vpns_bloc.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpn_card_items/add_vpn_button_list_item.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpn_card_items/empty_message_list_item.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpn_card_items/search_field_list_item.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpn_card_items/subtitle_vpn_list_item.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpn_card_items/vpn_list_item.dart';
import 'package:vpn_test/features/data_vpns/presentation/vpn_list_composer/vpns_list.dart';
import 'package:vpn_test/ui/widgets/add_vpn_button.dart';
import 'package:vpn_test/ui/widgets/empty_message.dart';
import 'package:vpn_test/ui/widgets/search_field.dart';
import 'package:vpn_test/ui/widgets/vpns_list/card_vpn_list.dart';
import 'package:vpn_test/ui/widgets/vpns_list/subtitle_vpn_list.dart';

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
            return _vpnsEmptySearchState();
          } else if (state is EmptyInitialDataVpnsState) {
            return _vpnsEmptyInitialState();
          }
          return Container();
        });
  }

  ListView _loadedState(LoadedDataVpnsState state) {
    VpnsCardsList cards = _defaultCards();
    cards.items
        .addAll(VpnsCardsList.fromVpnsInfoList(state.vpnsList, false).items);
    return ListView.builder(
        itemCount: cards.items.length,
        itemBuilder: (context, index) => _buildItem(index, cards));
  }

  VpnsCardsList _defaultCards() {
    VpnsCardsList baseCardsList = VpnsCardsList();
    baseCardsList.addItem(SearchFieldListItem());
    return baseCardsList;
  }

  ListView _vpnsEmptySearchState() {
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

  _vpnsEmptyInitialState() {
    var emptySearchMessageCards = _emptySearchMessageCards(
        "Нет результатов", "Пока что здесь пусто.\nДобавьте VPN");
    return ListView.builder(
        itemCount: emptySearchMessageCards.items.length,
        itemBuilder: (context, index) =>
            _buildItem(index, emptySearchMessageCards));
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
