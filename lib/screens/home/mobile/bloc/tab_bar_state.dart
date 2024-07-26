part of 'tab_bar_bloc.dart';

class TabState extends Equatable {
  final int index;

  const TabState({required this.index});

  @override
  List<Object> get props => [index];
}
