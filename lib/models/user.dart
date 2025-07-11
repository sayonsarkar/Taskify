class User {
  final String name;

  User({required this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(name: map['name']);
  }
}
