class ApiSocietyModel {
  String id = '';
  String name = '';
  String description = '';
  String university = '';
  String department = '';
  String adminEmail = '';
  String creationDate = '';
  String adminName = '';
  String goals = '';
  String societype = '';

  ApiSocietyModel();

  ApiSocietyModel.fromJson(
      {required this.id,
      required this.name,
      required this.description,
      required this.university,
      required this.department,
      required this.adminEmail,
      required this.creationDate,
      required this.adminName,
      required this.goals,
      required this.societype});
}
