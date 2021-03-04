part of 'learn_bloc.dart';

abstract class LearnEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchEvent extends LearnEvent {}
