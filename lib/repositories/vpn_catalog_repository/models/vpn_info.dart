// ignore_for_file: public_member_api_docs, sort_constructors_first
class VpnInfo {
  final int id;
  final String city;
  final int ping;
  final String country;
  final String countrutyCode;
  final bool isMine;
  final bool isActive;
  bool isFavorite;

  VpnInfo(
      {required this.id,
      required this.city,
      required this.ping,
      required this.country,
      required this.countrutyCode,
      required this.isMine,
      this.isFavorite = false,
      required this.isActive});
}
