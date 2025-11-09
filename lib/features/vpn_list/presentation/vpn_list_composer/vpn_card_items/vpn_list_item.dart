import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/vpn_list_item_interface.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';

class VpnListItem implements VpnListItemInterface {
  final int id;
  final String city;
  final int ping;
  final String country;
  bool isFavorite;
  final String countryCode;
  final bool isActive;

  VpnListItem({
    required this.id,
    required this.city,
    required this.ping,
    required this.country,
    required this.countryCode,
    required this.isActive,
    this.isFavorite = false,
  });

  factory VpnListItem.fromVpnInfo(VpnInfo vpnInfo) => VpnListItem(
        id: vpnInfo.id,
        city: vpnInfo.city,
        ping: vpnInfo.ping,
        country: vpnInfo.country,
        countryCode: vpnInfo.countrutyCode,
        isActive: vpnInfo.isActive,
        isFavorite: vpnInfo.isFavorite,
      );
}
