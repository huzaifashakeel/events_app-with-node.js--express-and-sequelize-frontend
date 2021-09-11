import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class SocietyInfo extends StatelessWidget {
  final ApiSocietyModel society;
  const SocietyInfo({Key? key, required this.society}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 10, bottom: 10),
          child: Row(
            children: [
              CustomText(
                text: "Afiliated to",
                fontWeight: FontWeight.w500,
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.12,
          width: width * 0.8,
          //color: Colors.white,
          //  child: Card(
          //  elevation: 2,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: width * 0.12)),
              CircleAvatar(
                backgroundImage: AssetImage("images/9.jpg"),
                radius: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: height * 0.015)),
                  CustomText(
                    text: society.university,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                  CustomText(
                    text: society.department + " Department",
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    size: 16,
                  ),
                ],
              )
            ],
          ),
          //),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 10, bottom: 10),
          child: Row(
            children: [
              CustomText(
                text: "Joining Date",
                fontWeight: FontWeight.w500,
                size: 18,
              ),
            ],
          ),
        ),
        Container(
            height: height * 0.05,
            width: width * 0.8,
            // color: Colors.white,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 5)),
                CustomText(
                  text: society.creationDate.substring(0, 10),
                  color: Colors.black54,
                  size: 16,
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 10, bottom: 10),
          child: Row(
            children: [
              CustomText(
                text: "Our Goals",
                fontWeight: FontWeight.w500,
                size: 18,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.1, 12, 12, 12),
              child: CustomText(
                text: society.goals,
                color: Colors.black54,
                size: 16,
              ),
            ),
          ],
        )
      ],
    );
  }
}
