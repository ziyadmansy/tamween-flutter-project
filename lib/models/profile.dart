class Profile {
  final int id;
  final String country;
  final String city;
  final String firstName;
  final String lastName;
  final double credit;

  Profile({
    required this.id,
    required this.country,
    required this.city,
    required this.firstName,
    required this.lastName,
    required this.credit,
  });

  factory Profile.fromJson(Map json) {
    return Profile(
      id: json['id'],
      country: json['country'],
      city: json['city'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      credit: double.parse(json['credit'].toString()),
    );
  }
}
