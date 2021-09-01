class ApiUserModel {
  String name = '';
  String bio = '';
  String address = '';
  String instaid = '';
  String userEmail = '';
  String dateofBirth = '';
  String phoneNumber = '';
  String university = '';
  String department = '';
  String registrationNo = '';

  ApiUserModel();

  ApiUserModel.fromjson(
      {required this.name,
      required this.bio,
      required this.address,
      required this.instaid,
      required this.userEmail,
      required this.dateofBirth,
      required this.phoneNumber,
      required this.university,
      required this.department,
      required this.registrationNo});
}
