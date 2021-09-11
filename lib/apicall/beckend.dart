import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';

abstract class BeckendFunctions {
  Future<int> signup(
      {required String username,
      required String email,
      required String password});

  Future<ApiUserSignUpModel> signIn(
      {required String email, required String password});

  Future<int> varifyUser(
      {required String name,
      required String bio,
      required String email,
      required String address,
      required String university,
      required String department,
      required String regno,
      required String phno,
      required String instaId,
      // required String profileimage,
      required String token});

  Future<int> createsociety(
      {required int id,
      required String socname,
      required String socdescription,
      required String adminemail,
      required String socuniversity,
      required String socdepartment,
      required String socgoals,
      required String societype,
      //required String logo,
      required String token});

  Future<int> createvent(
      {required String eventid,
      required String name,
      required String description,
      required String hostemail,
      required String address,
      required String adminname,
      required String hostsocietyname,
      required String hostsocietyid,
      required String eventDate,
      required String startingTime,
      required String endingTime,
      required bool isonline,
      required int participants,
      // required String profileimage,
      required String token});

  Future<ApiSocietyModel> getsociety(
      {required String id, required String token});

  Future<List<ApiEventModel>> getallevents({required String token});

  Future<ApiUserModel> loadEventhost(
      {required String hostemail, required String token});

  Future<bool> addorcheckEventMember(
      {required String useremail,
      required String eventid,
      required String token,
      required bool check});

  Future<bool> addorchecksocietyMember(
      {required String useremail,
      required String socid,
      required String token,
      required bool check});

  Future<int> addsocietyEvent(
      {required String eventid, required String socid, required String token});

  Future<List<ApiUserModel>> getsocietyMembers({
    required String socid,
    required String token,
  });

  Future<List<ApiUserModel>> geteventMembers({
    required String id,
    required String token,
  });

  Future<List<ApiEventModel>> getsocietyEvents({
    required String socid,
    required String token,
  });

  Future<List<ApiSocietyModel>> getmembersocieties({
    required String useremail,
  });

  Future<int> deleteEvent({required String eventid, required String token});

  Future<List<ApiSocietyModel>> getAdminSocieties(
      {required String email, required String token});

  Future<int> deleteSociety({required String socid, required String token});

  Future<int> updatevent(
      {required String eventid,
      required String name,
      required String description,
      required String address,
      required String eventDate,
      required String startingTime,
      required String endingTime,
      required bool isonline,
      required int participants,
      // required String profileimage,
      required String token});

  Future<int> updateUser(
      {required String name,
      required String bio,
      required String email,
      required String address,
      required String university,
      required String department,
      required String regno,
      required String phno,
      required String instaId,
      // required String profileimage,
      required String token});
}
