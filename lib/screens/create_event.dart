import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatefulWidget {
  final ApiSocietyModel eventorganizer;
  final String token;

  const CreateEvent(
      {Key? key, required this.eventorganizer, required this.token})
      : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
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
  String eventStartingTime = DateTime.now().toString().substring(11, 16);
  String eventendingTime = DateTime.now().toString().substring(11, 16);
  Beckend apiclass = new Beckend();
  // ignore: avoid_init_to_null
  late XFile? _image = null;

  ///late XFile? _image = null;
  late ImagePicker imagePicker = ImagePicker();
  getImage(bool isCamera) async {
    XFile? image;
    try {
      if (isCamera) {
        image = await imagePicker.pickImage(source: ImageSource.camera);
      } else {
        image = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
          print(_image);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String choosendate = "";
  void clearControllers() {
    eventname.text = "";
    eventaddress.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<EventProvider>(context);

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
                Container(
                  height: height * 0.3,
                  width: width,
                  color: Colors.grey,
                  child: ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(20),
                      //     bottomRight: Radius.circular(20)),
                      child: Stack(children: [
                    if (_image != null)
                      Image.file(
                        File(_image!.path),
                        fit: BoxFit.fill,
                        width: width,
                        height: height,
                      ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    if (_image == null)
                      ClipRect(
                          child: GestureDetector(
                              onTap: () {
                                getImage(false);
                              },
                              child: Center(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 0.0, sigmaY: 0.0),
                                    child: DottedBorder(
                                      dashPattern: [6, 6],
                                      borderType: BorderType.RRect,
                                      //radius: Radius.circular(10),
                                      strokeWidth: 2,
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomText(
                                          text: "Select a relevent photo",
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      ),
                                    )),
                              )))
                  ])),
                ),
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
                  text: "Enter Event Name",
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
                  text: 'choose how many people can join event',
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
                              hintText: eventdate.toString().substring(0, 10),
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
                                  hintText: eventStartingTime,
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
                                  print(time);
                                  eventendingTime =
                                      time.toString().substring(11, 16);
                                });
                              })
                            },
                            child: TextFormField(
                              enabled: false,
                              //controller: authProvider.password,
                              decoration: InputDecoration(
                                  hintText: eventendingTime,
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
                          value: isonline,
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
                    text: "Enter Event Address",
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
                    text: "Enter Event Description",
                    editingController: discription),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: Container(
                      height: height * 0.07,
                      width: width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              Random rand = new Random();
                              int evntid = rand.nextInt(9999999);
                              int res = await apiclass.createvent(
                                  name: eventname.text,
                                  description: discription.text,
                                  eventid: evntid.toString(),
                                  address: eventaddress.text,
                                  adminname: widget.eventorganizer.adminName,
                                  hostsocietyname: widget.eventorganizer.name,
                                  hostemail: widget.eventorganizer.adminEmail,
                                  hostsocietyid: widget.eventorganizer.id,
                                  eventDate: eventdate,
                                  startingTime: eventStartingTime,
                                  endingTime: eventendingTime,
                                  isonline: isonline,
                                  participants:
                                      int.parse(partcipantcontroller.text),
                                  token: widget.token);
                              if (res == 200) {
                                int added = await apiclass.addsocietyEvent(
                                    eventid: evntid.toString(),
                                    socid: widget.eventorganizer.id,
                                    token: widget.token);
                                if (added == 200) {
                                  clearControllers();
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Error while creating Event")));
                              }
                            }
                          },
                          child: CustomText(
                            text: "Create",
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
