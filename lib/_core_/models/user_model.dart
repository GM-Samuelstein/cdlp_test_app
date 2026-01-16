class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  /// -------------------------------
  /// Full name helper
  /// -------------------------------
  String get fullName => '$firstName $lastName';

  /// -------------------------------
  /// From JSON
  /// -------------------------------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  /// -------------------------------
  /// To JSON
  /// -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
