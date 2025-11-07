part of 'data_vpns_bloc.dart';

@immutable
sealed class DataVpnsState {}

final class InitialDataVpnsState extends DataVpnsState {}

final class LoadedDataVpnsState extends DataVpnsState {
  final List<VpnInfo> vpnsList;
  LoadedDataVpnsState({required this.vpnsList});
}

final class EmptySearchDataVpnsState extends DataVpnsState {}

final class EmptyInitialDataVpnsState extends DataVpnsState {}
