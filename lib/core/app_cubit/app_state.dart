part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ButtonIndexState extends AppState {}

final class ChangeNotificationState extends AppState {}

final class UpdateCache extends AppState {}

final class UpdateLocationLoading extends AppState {}

final class UpdateLocatingSuccess extends AppState {}

final class UpdateLocatingFailure extends AppState {}

final class UpdateLocatingConnectionFailure extends AppState {}
