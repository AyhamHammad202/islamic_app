part of 'tabs_cubit.dart';

@immutable
sealed class TabsState {}

final class TabsInitial extends TabsState {}

final class TabsChanged extends TabsState {
  final int index;

  TabsChanged(this.index);
}
