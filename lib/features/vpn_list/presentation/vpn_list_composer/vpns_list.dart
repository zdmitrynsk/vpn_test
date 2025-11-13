import 'package:vpn_test/features/vpn_list/mappers/vpn_list_composer/models/vpn_list_item_interface.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/subtitle_vpn_list_item.dart';
import 'package:vpn_test/features/vpn_list/presentation/vpn_list_composer/vpn_card_items/vpn_list_item.dart';

class VpnsCardsList {
  List<VpnListItemInterface> items = [];

  VpnsCardsList();

  static VpnsCardsList fromVpnsInfoList(
      List<VpnInfo> vpnInfoList, bool isAddSubtitles) {
    final List<VpnInfo> sorted = _sortVpnInfoList(vpnInfoList);
    final VpnsCardsList result =
        _convertToVpnsCardsList(sorted, isAddSubtitles);
    return result;
  }

  void addItem(VpnListItemInterface item) {
    items.add(item);
  }

  void addItemsList(VpnsCardsList vpnsList) {
    items.addAll(vpnsList.items);
  }

  static List<VpnInfo> _sortVpnInfoList(List<VpnInfo> vpnInfoList) {
    return [...vpnInfoList]..sort((a, b) {
        if (a.isMine != b.isMine) return a.isMine ? -1 : 1;

        return a.city.compareTo(b.city);
      });
  }

  static VpnsCardsList _convertToVpnsCardsList(
      List<VpnInfo> sortedVpns, bool isAddSubtitles) {
    final VpnsCardsList result = VpnsCardsList();
    String? currentCity;
    for (final vpnInfo in sortedVpns) {
      if (currentCity != vpnInfo.city && !vpnInfo.isMine && isAddSubtitles) {
        currentCity = vpnInfo.city;
        result.items.add(SubtitleVpnListItem(subtitle: vpnInfo.country));
      }
      result.items.add(VpnListItem.fromVpnInfo(vpnInfo));
    }
    return result;
  }
}
