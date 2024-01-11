part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ButtonIndexState extends AppState {}

final class DownloadLoading extends AppState {}

final class DownloadSuccess extends AppState {}

final class DownloadFailure extends AppState {}
