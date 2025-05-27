class Address {
  int id;
  String city;
  String block;
  String street;
  String building;
  int buildingNumber;

  Address({
    required this.id,
    required this.city,
    required this.block,
    required this.street,
    required this.building,
    required this.buildingNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        city: json["city"],
        block: json["block"],
        street: json["street"],
        building: json["building"],
        buildingNumber: json["building_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "block": block,
        "street": street,
        "building": building,
        "building_number": buildingNumber,
      };
}
