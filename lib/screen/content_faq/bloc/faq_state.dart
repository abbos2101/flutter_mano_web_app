part of 'faq_bloc.dart';

abstract class FaqState extends Equatable {
  const FaqState();
}

class LoadingState extends FaqState {
  final bool loading;
  final List<FaqModel> faqList;

  LoadingState({this.loading = false, this.faqList});

  @override
  List<Object> get props => [faqList];
}

class SuccessState extends FaqState {
  final List<FaqModel> faqList;

  SuccessState({this.faqList});

  @override
  List<Object> get props => [faqList];
}

class FailState extends FaqState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}
