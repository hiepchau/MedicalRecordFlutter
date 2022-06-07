class Diagnosis {
  String type;
  String problem;
  String date;
  String verifiedBy;
  bool verified = false;
  int id;
  Diagnosis({
    this.type,
    this.problem,
    this.date,
    this.verified,
    this.verifiedBy, 
    this.id,
  }) {
    verified = verified ?? false;
  }
  Map<String, dynamic> toMap() {
    return {
      'Type': this.type,
      'Problem': this.problem,
      'Date': this.date,
      'Verified': this.verified,
      'VerifiedBy': this.verifiedBy,
      'ID': this.id,
    };
  }
}
