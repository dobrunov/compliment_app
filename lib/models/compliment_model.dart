class Compliment {
  String id;
  String description;

  Compliment({
    this.id = "",
    required this.description,
  });

  factory Compliment.fromJson(Map<String, dynamic> json) {
    return Compliment(
      id: json['id'],
      description: json['description'],
    );
  }
}
