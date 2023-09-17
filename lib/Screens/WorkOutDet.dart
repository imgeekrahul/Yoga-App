import 'dart:async';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:yoga_app/Screens/Break.dart';
import 'package:yoga_app/Screens/Finish.dart';

import '../model/model.dart';
import '../services/yogadb.dart';


class WorkOutDet extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaIndex = 0;
  WorkOutDet({
    required this.ListOfYoga,
    required this.yogaIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create:(context) => TimerModelSec(context, ListOfYoga, yogaIndex+1, ListOfYoga[yogaIndex].SecondsOrTimes),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ListOfYoga[yogaIndex].YogaImgUrl)
                      )
                    ),
                  ),
                  Spacer(),
                  Text(ListOfYoga[yogaIndex].YogaTitle, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25 ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: ListOfYoga[yogaIndex].Seconds ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                          Text(" : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                          Consumer<TimerModelSec>(
                            builder: (context, myModel, child){
                              return Text(myModel.countDown.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white));
                            }
                          ),
                        ],
                      ) : Text("x${ListOfYoga[yogaIndex].SecondsOrTimes}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white))
                  ),
                  Spacer(),
                  SizedBox(height: 30, ),
                  Consumer<TimerModelSec>(
                    builder: (context, myModel, child){
                      return ElevatedButton(onPressed: (){myModel.show();}, 
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text("PAUSE", style: TextStyle(fontSize: 20))
                        )
                      );
                    }
                  ),

                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        yogaIndex != 0 ?
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BreakTime(ListOfYoga: ListOfYoga, yogaIndex: yogaIndex - 1)));
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorkOutDet(ListOfYoga: ListOfYoga, yogaIndex: yogaIndex - 1)));
                        }, child: Text("Previous", style: TextStyle(fontSize: 16))) : Container(), 
                        yogaIndex != ListOfYoga.length - 1 ? 
                        Consumer<TimerModelSec>(
                          builder: (context, myModel, child) {
                            return TextButton(onPressed: () async {
                              myModel.pass();
                              await Future.delayed(Duration(seconds: 1));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BreakTime(ListOfYoga: ListOfYoga, yogaIndex: yogaIndex + 1)));
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorkOutDet(ListOfYoga: ListOfYoga, yogaIndex: yogaIndex + 1)));
                            }, child: Text("Next", style: TextStyle(fontSize: 16)));
                          }
                        ) : Container(),
                      ],
                    ),
                  ),
                    
                  Divider(thickness: 2,),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text("Next: ${yogaIndex >= ListOfYoga.length -1 ? "FINISH" : ListOfYoga[yogaIndex + 1].YogaTitle}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      )
                    )

              ],),
            ),
            Consumer<TimerModelSec>(
              builder: (context, myModel, child){ 
              return Visibility(
                visible: myModel.visible ,
                child: Container(
                  color: Colors.blueAccent.withOpacity(0.9),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pause", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),
                      Text("Yoga Feels Better", style: TextStyle(fontSize: 13, color: Colors.white),),
                      SizedBox(height: 30,),
                      OutlinedButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorkOutDet(ListOfYoga: ListOfYoga, yogaIndex: 0)));
                      }, child: Container(
                        width: 180,
                        child: Text("RESTART", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                      )),
                      OutlinedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Container(
                        width: 180,
                        child: Text("QUIT", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                      )),
                      OutlinedButton(onPressed: (){myModel.hide();}, child: Container(
                        width: 180,
                        child: Text("RESUME", textAlign: TextAlign.center,),
                      ), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),)
                  ]),
                )
              );
            })
          ],
        )
      ),
    );
  }
}

class TimerModelSec with ChangeNotifier{
  TimerModelSec(context, List<Yoga> ListOfYoga, int yogaIndex, String countDownValue){ 
    setCDownValue(int.parse(countDownValue), ListOfYoga[yogaIndex-1].Seconds);
    MyTimerSec(context, ListOfYoga, yogaIndex);
    checkIsLast(yogaIndex >= ListOfYoga.length - 1);
  }
  int countDown = 0;
  void setCDownValue(int countDownValue, bool isSec) {
    countDown = isSec ? countDownValue : 10000 ;

  }
  
  // Comment-1: when click to resume button
  bool visible = false;

  bool isPassed = false;

  bool isLast = false;
  void checkIsLast(bool Ans) {
    isLast = true;
  }
  MyTimerSec(context, List<Yoga> ListOfYoga, int yogaIndex) async{
    Timer.periodic(Duration(seconds: 1), (timer) { 
      visible ? countDown+0 : countDown--;
      notifyListeners();
      if(countDown == 0) {
        timer.cancel();
        isLast ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Finish()))
        : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BreakTime(
          ListOfYoga: ListOfYoga, yogaIndex: yogaIndex,
        )));
      }
      else if(isPassed) {
        timer.cancel();
      }
    });
  }

  // Comment-1: when click to resume button
  void show() {
    visible = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }

  void pass() {
    isPassed = true;
  }

}