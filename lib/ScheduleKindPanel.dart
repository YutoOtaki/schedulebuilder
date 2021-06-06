import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulebuilder/ScheduleContentsPage.dart';
import 'ScheduleContents.dart';
import 'package:after_layout/after_layout.dart';

class ScheduleKindPanel extends StatefulWidget {
  final String title;
  final Gradient panelBackgroundGradient;
  final IconData panelIcon;

  //ScheduleKindPanel(this.title, this.panelBackgroundGradient, this.panelIcon);
  ScheduleKindPanel(this.title, this.panelBackgroundGradient, this.panelIcon);


  @override
  _ScheduleKindPanelState createState() => _ScheduleKindPanelState();
}

class _ScheduleKindPanelState extends State<ScheduleKindPanel> {

  int _contentsNumber;


  @override
  Widget build(BuildContext context) {

    //_contentsNumber = widget.contents.length;
    /*
    
    onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScheduleContentsPage(widget.panelBackgroundGradient))
          ).then((value){
            setState(() {
              //_contentsNumber = widget.contents.length;
            });
          });

        },
     */

    return InkWell(
        splashColor: Colors.white,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScheduleContentsPage(widget.panelBackgroundGradient),
                settings: RouteSettings(
                  arguments: Provider.of<ScheduleContents>(context, listen: false)
                )
          )
          ).then((value){
            setState(() {
              //_contentsNumber = widget.contents.length;
            });
          });
        },
        child: Ink(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: widget.panelBackgroundGradient),
          child: Row(
            children: <Widget>[
              Icon(
                widget.panelIcon,
                size: 110,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
              ),
              Spacer(),
              numberIcon(context, Provider.of<ScheduleContents>(context).contentsList.length),
              //numberIcon(context, _contentsNumber)
            ],
          ),
        ));
  }


  Widget numberIcon(BuildContext context, int _number) {

    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
      ),
      child: Center(
        child: Text(
          _number.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
      ),
    );
  }
}
