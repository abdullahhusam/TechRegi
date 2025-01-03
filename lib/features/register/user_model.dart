class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'emailaddress1': email,
      'adx_identity_passwordhash': password,
    };
  }
}
