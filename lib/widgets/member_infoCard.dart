import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class MemberInfo extends StatelessWidget {
  final ApiUserModel user;
  MemberInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      // onTap: () async {
      //   await socProvider.loadUserSocities(useruid: user.uid);
      //   changeScreen(context, ShowUserProfile(userModel: user));
      // },
      child: Container(
        height: height * 0.13,
        width: width * 0.9,
        child: Card(
          color: Colors.grey.shade100,
          elevation: 2,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: width * 0.03)),
              CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  child: ClipOval(child: Image.asset("images/7.jpg")
                      // FadeInImage.memoryNetwork(
                      //     placeholder: kTransparentImage,
                      //     image: user.profileimage),
                      ),
                  radius: 35),
              Padding(
                padding: EdgeInsets.fromLTRB(10, height * 0.0237, 0, 0),
                child: Column(
                  children: [
                    CustomText(
                      text: user.name,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: user.university + " ," + user.department,
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
