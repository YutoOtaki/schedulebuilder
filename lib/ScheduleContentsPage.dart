import 'dart:ui';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'ScheduleContents.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ScheduleContentsPage extends StatefulWidget {
  final Gradient pageBackgroundColor;

  ScheduleContentsPage(this.pageBackgroundColor);

  @override
  _ScheduleContentsPageState createState() => _ScheduleContentsPageState();
}

class _ScheduleContentsPageState extends State<ScheduleContentsPage> {

  var titleTextController = TextEditingController();
  var detailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final ScheduleContents contents = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Colors.black54,
          onPressed: () {
            //showSlideDialog(context: context, child: _scheduleCreatePage());
            AwesomeDialog(
                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,
                title: "Today's feeling is",
                body: _scheduleCreatePage(contents),
                btnCancelOnPress: (){}
            )
              ..show();
          },
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(gradient: widget.pageBackgroundColor),
          child: SafeArea(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),

                RaisedButton(
                    elevation: 25,
                    splashColor: Colors.white,
                    shape: CircleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 10
                        )
                    ),
                    onPressed: (){
                      if(contents.length ==0){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Item list is empty!!',
                          desc: 'You need to make schedule',
                          btnOkOnPress: () {},
                        )..show();
                      }else {

                        var _randomEvent = contents.random_event;
                        var _randomTitle = _randomEvent[0];
                        var _randomDetail = _randomEvent[1];
                        var _randomId = _randomEvent[2];

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.TOPSLIDE,
                          title: "Today's feeling is",
                          body: ScheduleCard(contents,_randomTitle, _randomDetail, _randomId),
                          btnOkOnPress: () {},
                        )
                          ..show();
                      }

                    },
                    child: Container(
                      height: 170,
                      width: 130,
                      decoration: BoxDecoration(
                          gradient: widget.pageBackgroundColor,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Text("Tap here",
                            style: TextStyle(fontSize: 25,color: Colors.white)),
                      ),
                    )

                ),
                Divider(color: Colors.white, thickness: 2,),

                Flexible(
                  flex: 2,
                  child: ListView.separated(
                    itemCount: contents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ScheduleCard(contents,contents.list[index][0],
                          contents.list[index][1], contents.list[index][2]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.transparent);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }

  Widget _scheduleCreatePage(ScheduleContents contents) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            "New schedule",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              decoration: TextDecoration.underline,
            ),
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Icon(Icons.assignment_turned_in),
                  Text(
                    "Schedule Title",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          TextField(
            enabled: true,
            autofocus: true,
            controller: titleTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Schedule title",
            ),
            onSubmitted: (String titleText) {
              print(titleTextController.text);
            },
          ),
          Align(
              child: iconButtonWithText(titleTextController),
              alignment: Alignment.topRight),
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Icon(Icons.assignment_turned_in),
                  Text(
                    "Detail",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          TextField(
            enabled: true,
            controller: detailTextController,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Detail",
            ),
            onSubmitted: (String detailText) {
              print(detailTextController.text);
            },
          ),
          Align(
              child: iconButtonWithText(detailTextController),
              alignment: Alignment.topRight),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          submitScheduleButton(contents, titleTextController, detailTextController)
        ],
      ),
    );
  }

  Widget iconButtonWithText(TextEditingController controller) {
    return RaisedButton.icon(
      icon: Icon(
        Icons.clear,
        color: Colors.white,
      ),
      label: Text(
        "clear",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        controller.clear();
      },
      color: Colors.grey,
      textColor: Colors.white,
    );
  }

  Widget submitScheduleButton(ScheduleContents contents,
      TextEditingController controller1, TextEditingController controller2) {
    return RaisedButton.icon(
            icon: Icon(
              Icons.create,
              color: Colors.white,
            ),
            label: Text(
              "Create Schedule",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              print(controller1.text.toString());
              print(controller2.text.toString());
              if (controller1.text.toString().replaceAll(" ", "") == "") {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Title is empty!!',
                  desc: 'You should enter a title.',
                  btnOkOnPress: () {},
                )..show();
              } else {
                setState(() {

                  contents.add(controller1.text.toString(), controller2.text.toString());
                  controller1.clear();
                  controller2.clear();
                });
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            color: Color(0xFF00CA71),
            textColor: Colors.white,
          );

  }

  Widget ScheduleCard(ScheduleContents contents, scheduleName, String detail, int idNumber){

    var deleteIsEnable = true;


          return Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                //gradient: FlutterGradients.glassWater(),
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          scheduleName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 25),
                        ),
                        Divider(
                          height: 3,
                          color: Colors.transparent,
                        ),
                        Text(
                          "detail",
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Text(
                          detail,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.info, size: 30,color: Colors.black54,),
                    onPressed: (){
                      showDialog(context: context,
                          builder: (context){
                            return SimpleDialog(
                              titlePadding: EdgeInsets.all(8),
                              contentPadding: EdgeInsets.all(8),
                              title: Text("Schedule information"),
                              children: <Widget>[
                                Text(scheduleName),
                                Divider(color: Colors.blue,
                                  thickness: 3,),
                                Text(detail)
                              ],
                            );
                          });
                    },

                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 30,color: Colors.black54,),
                    onPressed: (){

                      setState(() {
                        if(deleteIsEnable==true){
                          contents.remove(idNumber);
                          deleteIsEnable = false;
                        }

                      });

                    },
                  )
                ],
              ));
        }

}
