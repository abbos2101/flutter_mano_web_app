class PageModel {
  final int id;
  final String lessonIdString;
  final String lessonName;
  final bool word;
  final bool rule;
  final bool exercise;
  final bool dialog;
  final bool exam;
  final bool enabled;

  const PageModel({
    this.id,
    this.lessonIdString,
    this.lessonName,
    this.word,
    this.rule,
    this.exercise,
    this.dialog,
    this.exam,
    this.enabled,
  });
}
