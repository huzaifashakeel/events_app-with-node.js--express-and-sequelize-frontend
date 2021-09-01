import 'dart:convert';
import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:http/http.dart' as http;

class Beckend {
  List<ApiEventModel> events = [];
  List<ApiUserModel> societyfollowers = [];
  ApiUserModel eventhost = ApiUserModel();
  List<ApiSocietyModel> memberSocities = [];

  Future<int> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/signup/');
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> jsonmap = {
        'username': username,
        'email': email,
        'password': password
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(url,
          headers: headers, body: jsonString, encoding: encoding);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 403;
    }
  }

  Future<ApiUserSignUpModel> signIn(
      {required String email, required String password}) async {
    ApiUserSignUpModel user = new ApiUserSignUpModel();
    try {
      final params = {'username': email.trim(), 'password': password.trim()};
      final headers = {'Content-Type': 'application/json'};
      var url = Uri.parse('http://10.0.2.2:8000/api/signup/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.get(newurl, headers: headers);

      var userjson = jsonDecode(response.body)['data'][0];
      user = ApiUserSignUpModel.fromJson(
          username: userjson['username'],
          email: userjson['email'],
          isvarified: userjson['isvarified'],
          token: userjson['token']);
      return user;
    } catch (e) {
      print(e);
      return user;
    }
  }

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
      required String token}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/user/');
      final headers = {
        "Content-Type": "application/json",
        'Authorization': token
      };
      Map<String, dynamic> jsonmap = {
        'name': name,
        'userEmail': email,
        'bio': bio,
        'address': address,
        'instaid': instaId,
        'dateofBirth': '1988-10-12',
        'phoneNumber': phno,
        'university': university,
        'department': department,
        'registrationNo': regno,
        //  'profileimage': profileimage
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(url,
          headers: headers, body: jsonString, encoding: encoding);
      print(response.body);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 403;
    }
  }

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
      required String token}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/societies/');
      final headers = {
        "Content-Type": "application/json",
        'Authorization': token
      };
      Map<String, dynamic> jsonmap = {
        'societyid': id,
        'name': socname,
        'description': socdescription,
        'adminEmail': adminemail,
        'university': socuniversity,
        'department': socdepartment,
        'goals': socgoals,
        'societytype': societype,
        //'logo': logo
      };
      print(jsonmap);
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(url,
          headers: headers, body: jsonString, encoding: encoding);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 403;
    }
  }

  Future<ApiSocietyModel> getsociety(
      {required String id, required String token}) async {
    ApiSocietyModel society = new ApiSocietyModel();
    try {
      final params = {'societyid': id};
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/societies/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.get(newurl, headers: headers);

      var societyjson = jsonDecode(response.body)['data'][0];
      print(societyjson['socname']);
      society = ApiSocietyModel.fromJson(
          id: societyjson['societyid'],
          name: societyjson['socname'],
          description: societyjson['description'],
          university: societyjson['university'],
          department: societyjson['department'],
          adminEmail: societyjson['adminEmail'],
          adminName: societyjson['admin'],
          creationDate: societyjson['creationdate'],
          goals: societyjson['goals'],
          societype: societyjson['societytype']);
      return society;
    } catch (e) {
      print(e);
      return society;
    }
  }

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
      required String token}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/events/');
      final headers = {
        "Content-Type": "application/json",
        'Authorization': token
      };

      Map<String, dynamic> jsonmap = {
        'eventid': eventid,
        'name': name,
        'description': description,
        'hostemail': hostemail,
        'address': address,
        'admin': adminname,
        'hostsocietyname': hostsocietyname,
        'societyid': hostsocietyid,
        'eventDate': eventDate,
        'startingTime': startingTime,
        'endingTime': endingTime,
        'isonline': isonline,
        'totalParticipants': participants
        //  'profileimage': profileimage
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.post(url,
          headers: headers, body: jsonString, encoding: encoding);
      print(response.body);

      return response.statusCode;
    } catch (e) {
      print(e);
      return 403;
    }
  }

  Future<List<ApiEventModel>> getallevents({required String token}) async {
    try {
      final uri = Uri.parse('http://10.0.2.2:8000/api/events');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var res = await http.get(uri, headers: headers);
      int totalEvents = jsonDecode(res.body)['itemcount'];

      var eventsjson = jsonDecode(res.body)['data'];
      events = [];
      for (int i = 0; i < totalEvents; i++) {
        var event = eventsjson[i];
        events.add(ApiEventModel.fromjson(
            eventid: event['eventid'],
            name: event['name'],
            description: event['description'],
            hostEmail: event['hostemail'],
            creationDate: event['creationdate'],
            adminName: event['admin'],
            hostsociety: event['hostsocietyname'],
            societyid: event['societyid'],
            intrestcount: event['intrestcount'],
            eventDate: event['eventDate'],
            statrtingTime: event['startingTime'],
            endingTime: event['endingTime'],
            address: event['address'],
            isonline: event['isonline'],
            totalparticipants: event['totalParticipants']));
      }
      return events;
    } catch (err) {
      return events;
    }
  }

  Future<ApiUserModel> loadEventhost(
      {required String hostemail, required String token}) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/user');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': token
    };
    var params = {'hostemail': hostemail};
    var newurl = url.replace(queryParameters: params);
    var response = await http.get(newurl, headers: headers);
    var decodedData = jsonDecode(response.body);
    eventhost = ApiUserModel.fromjson(
        name: decodedData['name'],
        bio: decodedData['bio'],
        address: decodedData['address'],
        instaid: decodedData['instaid'],
        userEmail: decodedData['userEmail'],
        dateofBirth: decodedData['dateofBirth'],
        phoneNumber: decodedData['phoneNumber'],
        university: decodedData['university'],
        department: decodedData['department'],
        registrationNo: decodedData['registrationNo']);
    return eventhost;
  }

  Future<bool> addorcheckEventMember(
      {required String useremail,
      required String eventid,
      required String token,
      required bool check}) async {
    try {
      final params = {
        'userEmail': useremail.trim(),
        'eventid': eventid.trim(),
        'check': check.toString()
      };
      final headers = {
        "Content-Type": "application/json",
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/eventMembers/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.post(newurl, headers: headers);
      print(jsonDecode(response.body));
      return jsonDecode(response.body)['liked'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addorchecksocietyMember(
      {required String useremail,
      required String socid,
      required String token,
      required bool check}) async {
    try {
      final params = {
        'userEmail': useremail.trim(),
        'societyid': socid.trim(),
        'check': check.toString()
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/SocietyMembers/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.post(newurl, headers: headers);
      print(jsonDecode(response.body));
      return jsonDecode(response.body)['liked'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> addsocietyEvent(
      {required String eventid,
      required String socid,
      required String token}) async {
    try {
      final params = {'eventid': eventid.trim(), 'societyid': socid.trim()};
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/SocietyEvents/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.post(newurl, headers: headers);
      print(response.body);
      return response.statusCode;
    } catch (e) {
      print(e);
      return 403;
    }
  }

  Future<List<ApiUserModel>> getsocietyMembers({
    required String socid,
    required String token,
  }) async {
    try {
      final params = {
        'societyid': socid.trim(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/SocietyMembers/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.get(newurl, headers: headers);
      int membercount = jsonDecode(response.body)['membercount'];
      var decodedData = jsonDecode(response.body)['data'];
      societyfollowers = [];
      for (int i = 0; i < membercount; i++) {
        societyfollowers.add(ApiUserModel.fromjson(
            name: decodedData[i]['name'],
            bio: decodedData[i]['bio'],
            address: decodedData[i]['address'],
            instaid: decodedData[i]['instaid'],
            userEmail: decodedData[i]['userEmail'],
            dateofBirth: decodedData[i]['dateofBirth'],
            phoneNumber: decodedData[i]['phoneNumber'],
            university: decodedData[i]['university'],
            department: decodedData[i]['department'],
            registrationNo: decodedData[i]['registrationNo']));
      }
      return societyfollowers;
    } catch (e) {
      print(e);
      return societyfollowers;
    }
  }

  Future<List<ApiUserModel>> geteventMembers({
    required String id,
    required String token,
  }) async {
    List<ApiUserModel> eventfollowers = [];
    try {
      final params = {
        'eventid': id,
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/eventMembers/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.get(newurl, headers: headers);
      int membercount = jsonDecode(response.body)['membercount'];
      var decodedData = jsonDecode(response.body)['data'];

      for (int i = 0; i < membercount; i++) {
        eventfollowers.add(ApiUserModel.fromjson(
            name: decodedData[i]['name'],
            bio: decodedData[i]['bio'],
            address: decodedData[i]['address'],
            instaid: decodedData[i]['instaid'],
            userEmail: decodedData[i]['userEmail'],
            dateofBirth: decodedData[i]['dateofBirth'],
            phoneNumber: decodedData[i]['phoneNumber'],
            university: decodedData[i]['university'],
            department: decodedData[i]['department'],
            registrationNo: decodedData[i]['registrationNo']));
      }
      return eventfollowers;
    } catch (e) {
      print(e);
      return eventfollowers;
    }
  }

  Future<List<ApiEventModel>> getsocietyEvents({
    required String socid,
    required String token,
  }) async {
    List<ApiEventModel> societyevents = [];
    try {
      final params = {
        'societyid': socid.trim(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var url = Uri.parse('http://10.0.2.2:8000/api/SocietyEvents/');
      var newurl = url.replace(queryParameters: params);
      var response = await http.get(newurl, headers: headers);
      int eventcount = jsonDecode(response.body)['eventcount'];
      var eventsjson = jsonDecode(response.body)['data'];
      print(eventsjson);
      societyevents = [];
      for (int i = 0; i < eventcount; i++) {
        var event = eventsjson[i];
        societyevents.add(ApiEventModel.fromjson(
            eventid: event['eventid'],
            name: event['name'],
            description: event['description'],
            hostEmail: event['hostemail'],
            creationDate: event['creationdate'],
            adminName: event['admin'],
            hostsociety: event['hostsocietyname'],
            societyid: event['societyid'],
            intrestcount: event['intrestcount'],
            eventDate: event['eventDate'],
            statrtingTime: event['startingTime'],
            endingTime: event['endingTime'],
            address: event['address'],
            isonline: event['isonline'],
            totalparticipants: event['totalParticipants']));
      }
      print(societyevents);
      return societyevents;
    } catch (e) {
      print(e);
      return societyevents;
    }
  }

  Future<List<ApiSocietyModel>> getmembersocieties({
    required String useremail,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      var url =
          Uri.parse('http://10.0.2.2:8000/api/SocietyMembers/' + useremail);
      var response = await http.get(url, headers: headers);
      int societycount = jsonDecode(response.body)['societycount'];
      var decodedData = jsonDecode(response.body)['data'];

      for (int i = 0; i < societycount; i++) {
        var societyjson = decodedData[i];

        memberSocities.add(ApiSocietyModel.fromJson(
            id: societyjson['societyid'],
            name: societyjson['name'],
            description: societyjson['description'],
            university: societyjson['university'],
            department: societyjson['department'],
            adminEmail: societyjson['adminEmail'],
            adminName: societyjson['admin'],
            creationDate: societyjson['creationdate'],
            goals: societyjson['goals'],
            societype: societyjson['societytype']));
      }
      return memberSocities;
    } catch (e) {
      print(e);
      return memberSocities;
    }
  }

  Future<int> deleteEvent(
      {required String eventid, required String token}) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/events');
      final params = {
        'eventid': eventid.trim(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final newurl = url.replace(queryParameters: params);
      var res = await http.delete(newurl, headers: headers);
      // print(res.body);
      return res.statusCode;
    } catch (err) {
      return 500;
    }
  }

  Future<List<ApiSocietyModel>> getAdminSocieties(
      {required String email, required String token}) async {
    List<ApiSocietyModel> adminSocities = [];
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/societies/' + email);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
      var res = await http.get(url, headers: headers);
      var decodedData = jsonDecode(res.body)['data'];

      for (int i = 0; i < decodedData.length; i++) {
        var societyjson = decodedData[i];

        adminSocities.add(ApiSocietyModel.fromJson(
            id: societyjson['societyid'],
            name: societyjson['name'],
            description: societyjson['description'],
            university: societyjson['university'],
            department: societyjson['department'],
            adminEmail: societyjson['adminEmail'],
            adminName: societyjson['admin'],
            creationDate: societyjson['creationdate'],
            goals: societyjson['goals'],
            societype: societyjson['societytype']));
      }
      return adminSocities;
    } catch (err) {
      return adminSocities;
    }
  }

  Future<int> deleteSociety(
      {required String socid, required String token}) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/societies');
      final params = {
        'societyid': socid.trim(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final newurl = url.replace(queryParameters: params);
      var res = await http.delete(newurl, headers: headers);
      // print(res.body);
      return res.statusCode;
    } catch (err) {
      return 500;
    }
  }
}
