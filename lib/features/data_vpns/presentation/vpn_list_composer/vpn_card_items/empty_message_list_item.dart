import 'package:vpn_test/features/data_vpns/mappers/vpn_list_composer/models/vpn_list_item_interface.dart';

class MessageListItem implements VpnListItemInterface {
  String title;
  String message;
  MessageListItem(
    this.title,
    this.message,
  );
}
