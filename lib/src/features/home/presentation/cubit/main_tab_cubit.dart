import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_tab_state.dart';

class MainTabCubit extends Cubit<MainTabState> {
  MainTabCubit() : super(MainTabState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  @override
  Future<void> close() async {
    super.close();
  }

}
