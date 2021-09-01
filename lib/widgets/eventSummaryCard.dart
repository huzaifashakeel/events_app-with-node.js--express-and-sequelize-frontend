import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class EventSummaryCard extends StatelessWidget {
  final ApiEventModel event;

  const EventSummaryCard({required this.event});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height * 0.13,
          width: width * 0.9,
          child: Card(
            // color: Colors.amber,
            elevation: 2,
            child: Row(
              children: [
                Container(
                  height: height * 0.12,
                  width: width * 0.19,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10)),
                          CustomText(
                            text: "JULY",
                            color: Colors.white,
                          ),
                          CustomText(
                            text: event.eventDate.substring(8, 10),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                  width: width * 0.66,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5)),
                      CustomText(
                        text: event.name,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: event.eventDate +
                            " , " +
                            event.statrtingTime.substring(0, 5) +
                            " to " +
                            event.endingTime.substring(0, 5),
                        size: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                      CustomText(
                        text: event.address,
                        size: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
