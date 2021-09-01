import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventExplore_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  final ApiUserSignUpModel user;

  const ExplorePage({Key? key, required this.user}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Beckend apicall = new Beckend();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: apicall.getallevents(token: widget.user.token),
        builder:
            (BuildContext context, AsyncSnapshot<List<ApiEventModel>> result) {
          return Scaffold(
            body: SafeArea(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomText(
                  text: "Explore",
                  size: 20,
                  fontWeight: FontWeight.bold,
                  letterspacing: 5,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                      childAspectRatio: (_width * 0.45) / (_width * 0.64),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2,
                      physics: ScrollPhysics(),
                      children: apicall.events
                          .map((item) => EventExploreWidget(
                                event: item,
                                user: widget.user,
                              ))
                          .toList()),
                ),
              ),
            ])),
          );
        });
  }
}
