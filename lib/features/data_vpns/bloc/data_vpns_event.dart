// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_vpns_bloc.dart';

@immutable
sealed class DataVpnsEvent {}

class SearchDataVpnsEvent extends DataVpnsEvent {
  final FilterVpnType filterType;
  final String searchVpnsText;

  SearchDataVpnsEvent(this.searchVpnsText, this.filterType);
}

class TogleFavoriteDataVpnsEvent extends DataVpnsEvent {
  final int id;
  TogleFavoriteDataVpnsEvent({
    required this.id,
  });
}
