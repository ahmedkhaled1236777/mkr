class loginrequest {
  final String password;
  final String email;

  loginrequest({required this.password, required this.email});
  tojson() => {"password": password, "email": email};
}
