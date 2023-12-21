import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsInitial());

  int tab = 0;
  void changeTap(int index) {
    tab = index;
    emit(TabsChanged(tab));
  }
}
