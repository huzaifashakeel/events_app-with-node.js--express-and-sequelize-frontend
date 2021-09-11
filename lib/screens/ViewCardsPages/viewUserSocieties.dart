import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/widgets/SocietyRelated/society_infoCard.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class ViewMemberSocieties extends StatelessWidget {
  final List<ApiSocietyModel> memberSocieties;
  final ApiUserSignUpModel user;
  const ViewMemberSocieties(
      {Key? key, required this.memberSocieties, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomText(
                text: "My Socities",
                size: 20,
                fontWeight: FontWeight.bold,
                letterspacing: 5,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: memberSocieties
                    .map((e) => GestureDetector(
                          onTap: () {},
                          child: SocietyInfoCard(
                            society: e,
                            user: user,
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
