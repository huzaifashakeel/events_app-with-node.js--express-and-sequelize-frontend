import 'dart:ui';
import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditEvent extends StatefulWidget {
  final ApiEventModel event;
  final String token;

  const EditEvent({Key? key, required this.event, required this.token})
      : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<EditEvent> {
  final formkey = GlobalKey<FormState>();
  TextEditingController eventname = TextEditingController();
  TextEditingController eventaddress = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController partcipantcontroller = TextEditingController();
  String id = "";
  String eventdate = DateTime.now().toString();
  String image = "";
  String heldby = "";
  String startime = "";
  String endtime = "";
  String hostid = "";
  int intrestcount = 0;
  bool isonline = false;
  Beckend apiclass = new Beckend();

  String choosendate = "";
  void clearControllers() {
    eventname.text = "";
    eventaddress.text = "";
  }

  @override
  Widget build(BuildContext context) {
    String eventStartingTime = widget.event.statrtingTime;
    String eventendingTime = widget.event.endingTime;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomText(
                    text: "Edit Event Details",
                    size: 20,
                    fontWeight: FontWeight.bold,
                    letterspacing: 5,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Event Name',
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  text: widget.event.name,
                  editingController: eventname,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: CustomText(
                        text: 'Participants',
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  text: widget.event.totalparticipants.toString(),
                  editingController: partcipantcontroller,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Event Date",
                      color: Colors.black,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10, 10, 12),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        //color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                        // borderRadius: BorderRadius.circular(8),
                        color: Color(0XFFEFF3F6),
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(6, 2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0),
                          BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              offset: Offset(-6, -2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2100, 12, 8),
                              onChanged: (date) {
                            eventdate = date.toString();
                          }, onConfirm: (date) {
                            setState(() {
                              eventdate = date.toString().substring(0, 10);
                            });
                          })
                        },
                        child: TextFormField(
                          enabled: false,
                          //controller: authProvider.password,
                          decoration: InputDecoration(
                              labelText: widget.event.eventDate,
                              border: InputBorder.none,
                              icon: Icon(Icons.calendar_today)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Start Time",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                      Padding(padding: EdgeInsets.only(left: width * 0.2)),
                      CustomText(
                        text: "End Time",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0, 40, 0),
                      child: Container(
                        height: 40,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0XFFEFF3F6),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                offset: Offset(6, 2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                            BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                offset: Offset(-6, -2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0)
                          ],
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => {
                              DatePicker.showTimePicker(context,
                                  showTitleActions: true, onConfirm: (time) {
                                setState(() {
                                  print(time.toString());
                                  eventStartingTime =
                                      time.toString().substring(11, 16);
                                  print(eventStartingTime);
                                });
                              })
                            },
                            child: TextFormField(
                              enabled: false,
                              //controller: authProvider.password,
                              decoration: InputDecoration(
                                  labelText: eventStartingTime,
                                  border: InputBorder.none,
                                  icon: Icon(Icons.watch)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      child: Container(
                        height: 40,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0XFFEFF3F6),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                offset: Offset(6, 2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                            BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                offset: Offset(-6, -2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0)
                          ],
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => {
                              DatePicker.showTimePicker(context,
                                  showTitleActions: true, onConfirm: (time) {
                                setState(() {
                                  eventendingTime =
                                      time.toString().substring(11, 16);
                                });
                              })
                            },
                            child: TextFormField(
                              enabled: false,
                              //controller: authProvider.password,
                              decoration: InputDecoration(
                                  labelText: eventendingTime,
                                  border: InputBorder.none,
                                  icon: Icon(Icons.watch)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Online",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                      Padding(padding: EdgeInsets.only(left: width * 0.63)),
                      CupertinoSwitch(
                          activeColor: Colors.blue,
                          value: widget.event.isonline,
                          onChanged: (bool value) {
                            setState(() {
                              isonline = value;
                              print(isonline);
                            });
                          })
                    ],
                  ),
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Event Adress",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 14,
                    ),
                  ],
                ),
                CustomTextField(
                    text: widget.event.address,
                    editingController: eventaddress),
                Row(
                  children: [
                    CustomText(
                      text: "Event Description (Optional)",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 14,
                    ),
                  ],
                ),
                CustomTextField(
                    text: widget.event.description,
                    editingController: discription),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: Container(
                      height: height * 0.07,
                      width: width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              int res = await apiclass.updatevent(
                                  eventid: widget.event.eventid,
                                  name: eventname.text,
                                  description: discription.text,
                                  address: eventaddress.text,
                                  eventDate: eventdate,
                                  startingTime: eventStartingTime,
                                  endingTime: eventendingTime,
                                  isonline: isonline,
                                  participants:
                                      int.parse(partcipantcontroller.text),
                                  token: widget.token);

                              if (res == 200) {
                                clearControllers();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Error while creating Event")));
                              }
                            }
                          },
                          child: CustomText(
                            text: "Update",
                            fontWeight: FontWeight.bold,
                            size: 24,
                            color: Colors.white,
                          ))),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
