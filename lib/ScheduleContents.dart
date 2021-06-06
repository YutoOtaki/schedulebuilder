import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/iterables.dart';

class ScheduleContents extends ChangeNotifier{

  var contentsList = [];
  List<String> titleList = [];
  List<String> detailList = [];
  var idList = [];
  int contentId;

  String contentName;
  String contentNameTitleListName;
  String contentNameDetailListName;



  ScheduleContents(String contentName){
    this.contentName = contentName;
    this.contentNameTitleListName  = contentName + "titleList";
    this.contentNameDetailListName = contentName + "detailList";
    loadPref();

  }

  loadPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    titleList = prefs.getStringList(this.contentNameTitleListName) ?? [].cast<String>();
    detailList = prefs.getStringList(this.contentNameDetailListName) ?? [].cast<String>();
    contentId = prefs.getInt(this.contentName+"contentId") ?? 0;
    for (var pair in zip([titleList, detailList])) {
      contentsList.add([pair[0], pair[1], contentId]);
      idList.add(contentId);
      contentId++;
    }
    notifyListeners();

  }

  updatePref() async{
    print(this.contentName);
    print(titleList.runtimeType);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(this.contentNameTitleListName, titleList);
    prefs.setStringList(this.contentNameDetailListName, detailList);
    prefs.setInt(this.contentName + "contentId", contentId);
    print(prefs.getStringList(this.contentNameTitleListName));
    print("updated");
    notifyListeners();
  }

  add(String title, String detail){

    if(contentsList.length == 0){
      contentId = 0;
    }else{
      contentId++;
    }
    print([title, detail, contentId]);
    contentsList.add([title, detail, contentId]);
    titleList.add(title);
    detailList.add(detail);
    idList.add(contentId);
    updatePref();

  }

  remove(int idNumber){

    int deletePosition = idList.indexOf(idNumber);
    print("delete item is $deletePosition");
    contentsList.removeAt(deletePosition);
    titleList.removeAt(deletePosition);
    idList.removeAt(deletePosition);
    updatePref();
  }

  get nextId{
    return contentId + 1;
  }

  get random_event{
    int _random = Random().nextInt(contentsList.length);

    return contentsList[_random];
  }

  get list{
    return contentsList;
  }

  get length{
    if(contentsList.length == null){
      return 0;
    }
    else{
      return contentsList.length;
    }
  }


}