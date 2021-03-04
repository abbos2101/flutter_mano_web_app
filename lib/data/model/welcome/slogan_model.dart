class SloganModel {
  const SloganModel({this.id, this.sentence});

  final int id;
  final String sentence;

  factory SloganModel.empty() => SloganModel(id: 0, sentence: '');

  factory SloganModel.fromJson(Map<String, dynamic> json) =>
      SloganModel(id: json['id'], sentence: json['sentence']);
}
