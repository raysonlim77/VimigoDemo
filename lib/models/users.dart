class User {
  final String name;
  final String photoUrl;
  final int sales;

  User(this.name, this.photoUrl, this.sales);
  static List<User> generateUser() {
    return [
      User("Archie", "assets/profile/Archie.jpeg", 2200000),
      User("Charlotte", "assets/profile/Charlotte.jpeg", 3200000),
      User("Benjamin", "assets/profile/Benjamin.jpeg", 4500000),
      User("Aurora", "assets/profile/Aurora.jpeg", 4200000),
      User("Charlotte", "assets/profile/Charlotte.jpeg", 5700000),
      User("Henry", "assets/profile/Henry.jpeg", 3600000),
      User("Isabella", "assets/profile/Isabella.jpeg", 1600000),
      User("Scarlett", "assets/profile/Scarlett.jpeg", 3900000),
      User("Stella", "assets/profile/Stella.jpeg", 1900000),
      User("William", "assets/profile/William.jpeg", 3100000),
      User("Michael", "assets/profile/Michael.jpeg", 600000),
    ];
  }
}
