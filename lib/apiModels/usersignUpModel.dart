class ApiUserSignUpModel {
  String username = '';
  String email = '';
  bool isvarified = false;
  String token = '';

  ApiUserSignUpModel();

  ApiUserSignUpModel.fromJson(
      {required this.username,
      required this.email,
      required this.isvarified,
      required this.token});
}
