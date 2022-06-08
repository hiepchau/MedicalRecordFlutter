class History {
  String date;
  String description;
  String type;
  bool verified;

  History({this.date, this.description, this.type, this.verified});

  Map<String, dynamic> toMap() {
    return {
      'Date': date,
      'description': description,
      'Type': type,
      'Verified': verified,
    };
  }
}
