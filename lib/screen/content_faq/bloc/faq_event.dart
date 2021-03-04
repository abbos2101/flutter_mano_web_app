part of 'faq_bloc.dart';

abstract class FaqEvent extends Equatable {
  const FaqEvent();
}

class LaunchEvent extends FaqEvent {
  @override
  List<Object> get props => [];
}

class SendEvent extends FaqEvent {
  final String question;

  SendEvent({this.question});

  @override
  List<Object> get props => [question];
}
