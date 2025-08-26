part of 'main_tab_cubit.dart';

class MainTabState extends Equatable {

  const MainTabState({this.currentIndex = 0});

  final int currentIndex;

  @override
  List<Object?> get props => [currentIndex];

  MainTabState copyWith({ int? currentIndex }) {
    return MainTabState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}