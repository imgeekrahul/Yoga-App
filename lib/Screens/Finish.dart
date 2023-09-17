import 'package:flutter/material.dart';

class Finish extends StatelessWidget {
  const Finish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://img.freepik.com/premium-vector/gold-trophy-with-name-plate-winner-competition_68708-545.jpg", width: 350, height: 350,)
              ], 
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("125", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                    Text("KCal", style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  children: [
                    Text("12", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                    Text("Minutes", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("DO IT AGAIN", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                Text("SHARE", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Divider(thickness: 2,),
          Container(
            child: Column(
              children: [
                ElevatedButton(onPressed: (){}, child: Container(
                  width: MediaQuery.of(context).size.width - 70,
                  padding: const EdgeInsets.all(28.0),
                  child: Text("Rate Our App", style:TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                ),)
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Colors.grey,
          )
        ]
      ),
    );
  }
}