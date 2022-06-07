// ignore: camel_case_types
class basicRecord {
  String height;
  String weight;
  String rbc;
  String wbc;
  String bp;
  String sugarLevel;
  int count;
  basicRecord({
    this.height,
    this.weight,
    this.rbc,
    this.wbc,
    this.bp,
    this.sugarLevel,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'Height': height,
      'Weight': weight,
      'RBC Count': rbc,
      'WBC Count': wbc,
      'Sugar Level': sugarLevel,
      'Blood Pressure': bp,
      'Count': count ?? 0,
    };
  }
}
