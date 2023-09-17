import 'dart:async';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:yoga_app/Screens/WorkOutDet.dart';
import 'package:yoga_app/services/yogadb.dart';

import '../model/model.dart';

class BreakTime extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaIndex = 0;
  BreakTime({
    required this.ListOfYoga,
    required this.yogaIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) => TimerModelSec(context, ListOfYoga, yogaIndex),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover, 
              image: NetworkImage("https://images.unsplash.com/photo-1558017487-06bf9f82613a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=770&q=80") 
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text("Break Time", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              Consumer<TimerModelSec>(
                builder: (context, myModel, child){
                  return Text(myModel.countDown.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55, color: Colors.black));
                }
              ),
              SizedBox(height: 20),
              
              Consumer<TimerModelSec>(
                builder: (context, myModel, child) {
                  return ElevatedButton(onPressed: (){
                    myModel.skip();
                  }, child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    child: Text("SKIP ", style: TextStyle(fontSize: 19),),
                  ));
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
                          builder: (context, value, child) {
                            return TextButton(onPressed: () async {
                              value.pass();
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
                    child: Text("Next: ${yogaIndex >= ListOfYoga.length -1 ? "FINISH" : ListOfYoga[yogaIndex].YogaTitle}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}

class TimerModelSec with ChangeNotifier{
  TimerModelSec(context, List<Yoga> ListOfYoga, int yogaIndex){ 
    MyTimerSec(context, ListOfYoga, yogaIndex);
  }
  int countDown = 25;

  bool isPassed = false;

  bool isSkip = false;
  MyTimerSec(context, List<Yoga> ListOfYoga, int yogaIndex) async{
    Timer.periodic(Duration(seconds: 1), (timer) { 
      countDown--;
      notifyListeners();
      if(countDown == 0 || isSkip) {
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorkOutDet(
          ListOfYoga: ListOfYoga, yogaIndex: yogaIndex,
        )));
      } else if(isPassed) {
        timer.cancel();
      }
    });
  }

  void skip() {
    isSkip = true;
  }

  void pass() {
    isPassed = true;
  }
}