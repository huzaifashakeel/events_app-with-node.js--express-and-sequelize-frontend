import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
// import 'package:events_app/apiModels/userModel.dart';
// import 'package:events_app/apicall/becend_functions_call.dart';
// import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/society_infoCard.dart';
// import 'package:events_app/widgets/member_infoCard.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ViewMemberSocieties extends StatelessWidget {
  final List<ApiSocietyModel> memberSocieties;
  final ApiUserSignUpModel user;
  const ViewMemberSocieties(
      {Key? key, required this.memberSocieties, required this.user})
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
