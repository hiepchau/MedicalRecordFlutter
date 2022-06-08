class Doctor {
  final String uid;
  final String govtID;

  Doctor({
    this.uid,
    this.govtID,
  });

  Map<String, dynamic> toMap() {
    return {
      'Govt ID': govtID,
    };
  }
}