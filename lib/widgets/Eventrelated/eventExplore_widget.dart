import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/Details/eventDetails.dart';
import 'package:events_app/screens/mainPages/loading.dart';
import 'package:flutter/material.dart';

class EventExploreWidget extends StatelessWidget {
  final ApiEventModel event;
  final ApiUserSignUpModel user;

  const EventExploreWidget({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    Beckend apicall = Beckend();
    bool isadmin = false;
    if (event.hostEmail == user.email) {
      isadmin = true;
    }

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    print(user.isvarified);
                    if (user.isvarified) {
                      ApiUserModel host = await apicall.loadEventhost(
                          hostemail: event.hostEmail, token: user.token);
                      ApiSocietyModel hostsociety = await apicall.getsociety(
                          id: event.societyid, token: user.token);
                      List<ApiUserModel> eventfollowers =
                          await apicall.geteventMembers(
                              id: event.eventid, token: user.token);

                      changeScreen(
                          context,
                          EventDetails(
                            event: event,
                            eventhost: host,
                            eventfollowers: eventfollowers,
                            showhostsoc: true,
                            user: user,
                            hostSociety: hostsociety,
                            isadmin: isadmin,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You must complete your information to view Event")));
                    }
                  },
                  child: Container(
                      height: _height * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.amber,
                      ),
                      child: Stack(
                        children: [
                          Loading(),
                          Image.asset(
                            "images/1.jpg",
                            fit: BoxFit.cover,
                            height: _height * 0.24,
                          )
                          // FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   image: this.event.image,
                          //   height: _height * 0.2,
                          //   //height: 200,
                          //   fit: BoxFit.fill,
                          //   width: double.infinity,
                          // ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Chip(
                      label: Text(
                        'Online',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black87,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 5, right: 5),
              title: Text(event.name),
              dense: true,
              isThreeLine: true,
              subtitle: Text(
                event.address,
              ),
            )
          ],
        ),
      ),
    );
  }
}
