import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:provider/provider.dart';
import 'ScheduleKindPanel.dart';
import 'ScheduleContents.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// 天気の情報も入れたい
// 予算ルーレット（なんでも鑑定団みたいな感じ）の機能の追加
// 普通ばーじょんとおふざけバージョンの実装
// 色使いの改善→誰をターゲットとしたときに良い色か。どんな理論に基づいたときに良い色づかいか。
// パッケージングでマネタイズ
// パッケージのためのタグ付機能

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ScheduleContents foodsContents = ScheduleContents("Foods");
  final ScheduleContents sweetsContents = ScheduleContents("Sweets");
  final ScheduleContents goOutContents = ScheduleContents("Go_Out");
  final ScheduleContents atHomeContents = ScheduleContents("At_Home");
  final ScheduleContents otherContents = ScheduleContents("Other");


  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: GradientAppBar(
            title: Text("Schedule Builder"),
            /*
            leading: IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                print("Pushed");
              },
            ),

             */
            gradient: FlutterGradients.frozenHeat()
            ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: <Widget>[
              ChangeNotifierProvider<ScheduleContents>(
                  create: (context) => foodsContents,
                child: ScheduleKindPanel(
                    "Foods",
                    FlutterGradients.angelCare(),
                    Icons.restaurant,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ChangeNotifierProvider<ScheduleContents>(
                create: (context) => sweetsContents,
                child: ScheduleKindPanel(
                  "Sweets",
                  FlutterGradients.temptingAzure(),
                  Icons.cake,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ChangeNotifierProvider<ScheduleContents>(
                create: (context) => goOutContents,
                child: ScheduleKindPanel(
                    "Go Out",
                    FlutterGradients.crystalRiver(),
                    Icons.directions_bike,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ChangeNotifierProvider<ScheduleContents>(
                create: (context) => atHomeContents,
                child: ScheduleKindPanel(
                    "At Home",
                    FlutterGradients.witchDance(),
                    Icons.home,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ChangeNotifierProvider<ScheduleContents>(
                create: (context) => otherContents,
                child: ScheduleKindPanel(
                    "Other",
                    FlutterGradients.moleHall(),
                    Icons.apps,
                )
              ),

            ],
          ),
        ));
  }
}

