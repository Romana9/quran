part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ButtonIndexState extends AppState {}

final class UpdateCache extends AppState {}
