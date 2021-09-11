import 'dart:io';
import 'dart:ui';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/mainPages/homePage.dart';

import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final ApiUserModel? user;
  final ApiUserSignUpModel userSignUpModel;

  const EditProfile(
      {Key? key, required this.user, required this.userSignUpModel})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfile> {
  TextEditingController userName = TextEditingController();
  TextEditingController userBio = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userUniversity = TextEditingController();
  TextEditingController userDepartment = TextEditingController();
  TextEditingController userPhNo = TextEditingController();
  TextEditingController userInsta = TextEditingController();
  TextEditingController userregNo = TextEditingController();

  String userDOB = "";
  String userEmail = "";
  String userid = "";
  final formkey = GlobalKey<FormState>();

  void clearControllers() {
    userBio.text = "";
    userCity.text = "";
    userDOB = "";
    userDepartment.text = "";
    userInsta.text = "";
    userName.text = "";
    userPhNo.text = "";
    userUniversity.text = "";
  }

  Beckend apicall = new Beckend();
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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                // Container(
                //   width: double.maxFinite,
                //   height: _size.height * 0.30,
                //   color: Colors.red,
                //   child: _image == null
                //       ? Image.asset(
                //           "images/14.jpg",
                //           fit: BoxFit.cover,
                //         )
                //       : Image.file(
                //           File(_image!.path),
                //           fit: BoxFit.cover,
                //           height: 100,
                //           width: 100,
                //         ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Container(
                //       height: _size.height * 0.15,
                //       child: Column(
                //         children: [
                //           TextButton(
                //               onPressed: () {}, child: Text("View Photo")),
                //           Divider(
                //             thickness: 2,
                //           ),
                //           TextButton(
                //               onPressed: () {
                //                 getImage(false);
                //               },
                //               child: Text("Select Photo"))
                //         ],
                //       ),
                //     )));
                //   },
                // child:
                // BackdropFilter(
                //   filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                //   child: Container(
                //     width: double.maxFinite,
                //     height: _size.height * 0.30,
                //     color: Colors.black.withOpacity(0.3),
                //   ),
                //   //    ),
                // )

                Padding(
                  padding: EdgeInsets.only(top: _size.height * 0.02, left: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.black)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ))),
                ),
                // if (_image == null)
                //   Center(
                //     child: Padding(
                //       padding: EdgeInsets.only(top: _size.height * 0.1),
                //       child: Column(
                //         children: [
                //           ClipRect(
                //             child: GestureDetector(
                //               onTap: () {

                //               },
                //               child: BackdropFilter(
                //                 filter: ImageFilter.blur(
                //                     sigmaX: 10.0, sigmaY: 10.0),
                //                 child: DottedBorder(
                //                     padding: EdgeInsets.all(16),
                //                     dashPattern: [6, 6],
                //                     borderType: BorderType.RRect,
                //                     // radius: Radius.circular(10),
                //                     strokeWidth: 2,
                //                     color: Colors.white,
                //                     child: CustomText(
                //                       text: "Tap to select photo",
                //                       color: Colors.white,
                //                       size: 14,
                //                     )),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: _size.height * 0.08, bottom: _size.height * 0.03),
                    child: Container(
                      height: _size.width * 0.4,
                      width: _size.width * 0.4,
                      decoration: BoxDecoration(
                        // image: new DecorationImage(
                        //   image: new ExactAssetImage('images/7.jpg'),
                        //   fit: BoxFit.cover,
                        // ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:
                          // Stack(
                          //   children: [
                          GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Container(
                            height: 100,
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      getImage(true);
                                    },
                                    child: Text("Camra")),
                                TextButton(
                                    onPressed: () {
                                      getImage(false);
                                    },
                                    child: Text("Select from Gallery")),
                              ],
                            ),
                          )));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CircleAvatar(
                            radius: 100,
                            child: _image == null
                                ? Image.asset("images/13.jpg")
                                : Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                    height: _size.height * 0.2,
                                    width: _size.width * 0.4,
                                  ),
                          ),
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     // ClipRect(
                      //     //   child: GestureDetector(
                      //     //     onTap: () {
                      //     //       getImage(false);
                      //     //     },
                      //     //     child: BackdropFilter(
                      //     //       filter: ImageFilter.blur(
                      //     //           sigmaX: 10.0, sigmaY: 10.0),
                      //     //       child: DottedBorder(
                      //     //         dashPattern: [6, 6],
                      //     //         borderType: BorderType.RRect,
                      //     //         radius: Radius.circular(10),
                      //     //         strokeWidth: 2,
                      //     //         color: Colors.white,
                      //     //         child: CustomText(
                      //     //           text: "select photo",
                      //     //           color: Colors.white,
                      //     //           size: 16,
                      //     //         ),
                      //     //         // child: IconButton(
                      //     //         //     onPressed: () {},
                      //     //         //     icon: Icon(
                      //     //         //       Icons.camera_alt_outlined,
                      //     //         //       color: Colors.white,
                      //     //         //     )),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     // Padding(
                      //     //   padding: const EdgeInsets.all(8.0),
                      //     //   child: CustomText(
                      //     //     text: 'Change Image',
                      //     //     color: Colors.white,
                      //     //     size: 13,
                      //     //   ),
                      //     // )
                      //   ],
                      // ),
                      //   ],
                      //),
                    ),
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('Name', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userName,
                text: widget.user!.name,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('Bio', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userBio,
                maxLines: 10,
                text: widget.user!.bio,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('City', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userCity,
                text: widget.user!.address,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('University',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userUniversity,
                text: widget.user!.university,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Department',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userDepartment,
                text: widget.user!.department,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Reg No',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userregNo,
                text: widget.user!.registrationNo,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Phone Number',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userPhNo,
                text: widget.user!.phoneNumber,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Instagram ID',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userInsta,
                text: widget.user!.instaid,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              // String profilepiclink = await uploadPic(
                              //     imagefile: File(_image!.path));
                              int resstatus = await apicall.updateUser(
                                name: userName.text,
                                bio: userBio.text,
                                address: userCity.text,
                                department: userDepartment.text,
                                email: widget.user!.userEmail,
                                instaId: userInsta.text,
                                phno: userPhNo.text,
                                university: userUniversity.text,
                                regno: userregNo.text,
                                token: widget.userSignUpModel.token,
                                //  profileimage: profilepiclink,
                              );

                              if (resstatus == 200) {
                                changeScreenReplacement(context,
                                    HomePage(user: widget.userSignUpModel));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Problem Occured while varifying'),
                                ));
                              }
                              // // // // String profilepiclink = await uploadPic(
                              // // // //     imagefile: File(_image!.path));
                              // // // // Loading();
                              // // // // if (!await userProvider.createUser(
                              // // // //   userName.text,
                              // // // //   userCity.text,
                              // // // //   userInsta.text,
                              // // // //   userUniversity.text,
                              // // // //   userDepartment.text,
                              // // // //   "10-12-1990",
                              // // // //   userBio.text,
                              // // // //   userPhNo.text,
                              // // // //   widget.useremail.toString(),
                              // // // //   profilepiclink,
                              // // // )) {
                              // //   print("error in adding User");
                              // } else {
                              //   clearControllers();
                              //   userProvider.isvar = true;
                              //   // changeScreenReplacement(context,
                              //   //     HomePage(useremail: widget.useremail));
                              //   // print("User Added");
                              // }
                            }
                          },
                          child: CustomText(
                            text: "Update",
                            fontWeight: FontWeight.bold,
                            size: 24,
                            color: Colors.white,
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
