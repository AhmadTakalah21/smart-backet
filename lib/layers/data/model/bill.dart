List<Bill> getBillList(List<dynamic> str) =>
    List<Bill>.from(str.map((x) => Bill.fromJson(x)));

class Bill {
  int id;
  String status;
  DateTime createdAt;
  int price;

  Bill({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.price,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "price": price,
      };
}
