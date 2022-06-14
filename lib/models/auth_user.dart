class AppUser {
  final String uid;
  AppUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugar;
  final String coffeeMate;
  final int strength;

  UserData({
    this.uid,
    this.name,
    this.sugar,
    this.coffeeMate,
    this.strength,
  });
}
