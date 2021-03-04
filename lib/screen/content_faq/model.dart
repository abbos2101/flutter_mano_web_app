enum FaqType {
  WORD,
  RULE,
  EXERCISE_CHECK,
  EXERCISE_SENTENCE,
  EXERCISE_PICTURE,
  EXERCISE_PUTWORD,
  DIALOG_WORD,
  DIALOG_SENTENCE,
}

class ItemModel {
  final bool admin;
  final String text;
  final String login;
  final bool publish;

  const ItemModel({this.admin, this.text, this.login, this.publish});
}
