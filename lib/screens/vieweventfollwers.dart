import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/helpers/screen_nav.dart';
// import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/showUserProfile.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/member_infoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewEventFollowers extends StatelessWidget {
  final List<ApiUserModel> eventfollowers;
  final ApiUserSignUpModel user;

  const ViewEventFollowers(
      {Key? key, required this.eventfollowers, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomText(
                text: "Who is Going ?",
                size: 20,
                fontWeight: FontWeight.bold,
                letterspacing: 5,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: eventfollowers
                    .map((e) => GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                ShowUserProfile(
                                  userModel: e,
                                  userSignUpModel: user,
                                ));
                          },
                          child: MemberInfo(
                            user: e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
