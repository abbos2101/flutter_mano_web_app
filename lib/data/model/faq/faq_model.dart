class FaqModel {
  const FaqModel({
    this.id,
    this.question,
    this.clientId,
    this.clientLogin,
    this.type,
    this.itemId,
    this.status,
    this.answers,
  });

  final int id;
  final String question;
  final int clientId;
  final String clientLogin;
  final String type;
  final int itemId;
  final String status;
  final List<ItemFaqAnswer> answers;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["question"],
        clientId: json["clientId"],
        clientLogin: json["clientLogin"],
        type: json["type"],
        itemId: json["itemId"],
        status: json["status"],
        answers: json["answers"] == null
            ? []
            : List<ItemFaqAnswer>.from(
                json["answers"].map((x) => ItemFaqAnswer.fromJson(x))),
      );
}

class ItemFaqAnswer {
  const ItemFaqAnswer({
    this.id,
    this.answer,
    this.adminId,
    this.adminName,
  });

  final int id;
  final String answer;
  final String adminId;
  final String adminName;

  factory ItemFaqAnswer.fromJson(Map<String, dynamic> json) => ItemFaqAnswer(
        id: json["id"],
        answer: json["answer"],
        adminId: json["adminId"],
        adminName: json["adminName"],
      );
}
