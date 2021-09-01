class ApiEventModel {
  String eventid = '';
  String name = '';
  String description = '';
  String hostEmail = '';
  String creationDate = '';
  String adminName = '';
  String hostsociety = '';
  String societyid = '';
  int intrestcount = 0;
  String eventDate = '';
  String statrtingTime = '';
  String endingTime = '';
  String address = '';
  bool isonline = false;
  int totalparticipants = 0;

  ApiEventModel();

  ApiEventModel.fromjson(
      {required this.eventid,
      required this.name,
      required this.description,
      required this.hostEmail,
      required this.creationDate,
      required this.adminName,
      required this.hostsociety,
      required this.societyid,
      required this.intrestcount,
      required this.eventDate,
      required this.statrtingTime,
      required this.endingTime,
      required this.address,
      required this.isonline,
      required this.totalparticipants});
}
