import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:events_app/apiModels/EventModel.dart';

class EventBloc {
  static EventBloc of(BuildContext context) {
    return EventBloc.of(context);
  }

  static Future<List<ApiEventModel>> getsocietyEvents({
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
      return societyevents;
    } catch (e) {
      return societyevents;
    }
  }

  static Future<int> createvent(
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

  static Future<List<ApiEventModel>> getallevents(
      {required String token}) async {
    List<ApiEventModel> events = [];
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
}
