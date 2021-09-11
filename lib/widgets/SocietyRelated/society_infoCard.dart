import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/Details/society_details.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class SocietyInfoCard extends StatelessWidget {
  final ApiUserSignUpModel user;
  final ApiSocietyModel society;
  SocietyInfoCard({required this.society, required this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Beckend apicall = Beckend();
    List<ApiUserModel> users = [];
    List<ApiEventModel> societyevents = [];

    bool isadmin;

    return GestureDetector(
      onTap: () async {
        if (society.adminEmail == user.email) {
          isadmin = true;
        } else {
          isadmin = false;
        }
        users = await apicall.getsocietyMembers(
            socid: society.id, token: user.token);
        societyevents = await apicall.getsocietyEvents(
            socid: society.id, token: user.token);

        changeScreen(
            context,
            SocietyDetails(
              society: society,
              user: user,
              societyFollowers: users,
              societyEvents: societyevents,
              isadmin: isadmin,
            ));
      },
      child: Container(
        height: height * 0.13,
        width: width * 0.9,
        child: Material(
          color: Colors.white,
          elevation: 02,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: width * 0.03)),
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                backgroundImage: AssetImage("images/11.png"),
                // child: FadeInImage.memoryNetwork(
                //     placeholder: kTransparentImage, image: user.profileimage),
                radius: 33,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: society.name,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: society.university + " ," + society.department,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      size: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
