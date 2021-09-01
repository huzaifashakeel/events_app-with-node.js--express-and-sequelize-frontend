import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
// import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/member_infoCard.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ViewSocietyMembers extends StatelessWidget {
  final List<ApiUserModel> societyfollowers;
  const ViewSocietyMembers({Key? key, required this.societyfollowers})
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
                text: "Members",
                size: 20,
                fontWeight: FontWeight.bold,
                letterspacing: 5,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: societyfollowers
                    .map((e) => GestureDetector(
                          onTap: () {},
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
