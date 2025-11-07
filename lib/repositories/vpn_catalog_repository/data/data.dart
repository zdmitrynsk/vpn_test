import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';

final List<VpnInfo> vpnListData = [
  VpnInfo(
      id: 0,
      city: 'Берлин',
      country: "Германия",
      countrutyCode: 'de',
      ping: 120,
      isMine: true,
      isActive: true),
  VpnInfo(
      id: 1,
      city: 'Берлин',
      country: "Германия",
      countrutyCode: 'de',
      ping: 121,
      isMine: true,
      isActive: false),
  VpnInfo(
      id: 2,
      city: 'Берлин',
      country: "Германия",
      countrutyCode: 'de',
      ping: 122,
      isMine: false,
      isActive: false),
  VpnInfo(
      id: 3,
      city: 'Нью йорк',
      country: "США",
      countrutyCode: 'us',
      ping: 123,
      isMine: false,
      isActive: false),
  VpnInfo(
      id: 4,
      city: 'Нью йорк',
      country: "США",
      countrutyCode: 'us',
      ping: 124,
      isMine: false,
      isActive: false),
];
