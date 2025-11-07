import 'package:vpn_test/repositories/vpn_catalog_repository/models/filter_type.dart';
import 'package:vpn_test/repositories/vpn_catalog_repository/models/vpn_info.dart';

abstract interface class VpnCatalogRepositoryI {
  List<VpnInfo> getVpnsInfo(FilterVpnType filter, String city);
  void togleFavorite(int id);
}
