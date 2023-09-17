import 'package:flutter/material.dart';
import 'package:yoga_app/Screens/Startup.dart';
import 'package:yoga_app/Widgets/CustomAppBar.dart';
import 'package:yoga_app/Widgets/CustomDrawer.dart';

import '../model/model.dart';
import '../services/yogadb.dart';

//  class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Bharat Yoga App"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text("1"),
//                       Text("Streak")
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text("1"),
//                       Text("Streak")
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text("1"),
//                       Text("Streak")
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Divider(thickness: 3, indent: 20, endIndent: 20,),
//             Container(
//               padding: EdgeInsets.all(25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Yoga For All"),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   )
//                 ]
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Yoga For Students"),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Container(
//                       color: Colors.blueGrey,
//                       height: 150,
//                     ),
//                   )
//                 ]
//               ),
//             )
//           ],
//         ),
//       )
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  // Comment-6 : To use the customAppBar, we need to initialise the variables present in the customAppBar privatly using `late` keyword

  late AnimationController _animationController;
  late Animation _colorTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  Future makeYogaEntry(Yoga yoga, String TableName) async {
    await YogaDatabase.instance.Insert(yoga, TableName);
  }

  Future makeYogaSumEntry(YogaSummary yogaSummary) async {
    await YogaDatabase.instance.InsertYogaSum(yogaSummary);
  }

  // Reading the yoga
  bool isLoading = true;
  late List<YogaSummary> yogasumlst;

  Future readYogaSumEntry() async{
    print("Hello");

    this.yogasumlst = await YogaDatabase.instance.readAllYogaSum();

    print(yogasumlst);
    setState((){
      
      isLoading = false;
    });
    
    
      // print(yogasumlst[0].YogaWorkOutName.toString());
    
  }


  // Comment-7 : Specifies the initState method to initate the operation
  @override
  void initState() {
    // TODO: implement initState


    // Comment-8 : After calling initState() method, initialise the values to the variables.
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue).animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue).animate(_animationController);
    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _textAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));


    // Creating one yoga workout pack
    // makeYogaSumEntry(YogaSummary(YogaWorkOutName: YogaModel.YogaTable1, BackImg: "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1220&q=80CKIMAGURL", TimeTaken: "36", TotalNoOfWork: "12", Yogakey: 1));
    // makeYogaEntry(Yoga(Seconds: false, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Third Asan", SecondsOrTimes: '16', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(Seconds: true, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Anulom Vilom", SecondsOrTimes: '30', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(Seconds: true, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Kapalbhati", SecondsOrTimes: '15', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(Seconds: true, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Pranam", SecondsOrTimes: '12', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(Seconds: true, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Shwasari", SecondsOrTimes: '16', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(Seconds: true, YogaImgUrl: "https://images.squarespace-cdn.com/content/v1/5e13030d166215441db6be9c/1579169359456-Z0OGVGKO6LXEG4HZDJ3D/Yoga-Flow-Animation.gif?format=2500w", YogaTitle: "Shwasari", SecondsOrTimes: '16', YogaKey_WorkOuts: 1), YogaModel.YogaTable1);
    readYogaSumEntry();
    

    // Creating second yoga pack
    super.initState();
  }

  //  Comment-9 : Created a function scrollListener to boolean type to check whether the user is scrolling or not.
  bool scrollListener(ScrollNotification scrollNotification) {
    bool scroll = false;
    if(scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels/80); // created a short transition
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);

      return scroll = true;
    }
    return scroll;
  }

  //  Comment-12 : To work by clicking onPressed button
  /*
  * First we need to create a key of Scaffold by which the Drawer() under the Scaffold opens in the UI.
  *
  *
  */

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  
  //  Comment-10 : Created a HomePage Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  Comment-13 : Without specifying the key, drawer won't work.
      key: scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: NotificationListener( // Detects the scroll Notification
        onNotification: scrollListener,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(50, 120, 50, 30),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text("1", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23
                                      )),
                                      Text("Streak", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13
                                      ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("120", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23
                                      )),
                                      Text("kCal", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13
                                      ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("26", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23
                                      )),
                                      Text("Minutes", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container( 
                                    padding: EdgeInsets.only(bottom: 15, ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Yoga For All", style: TextStyle(
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: yogasumlst.length,
                                    itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Startup(yogaSum: yogasumlst[index], YogaKey: yogasumlst[index].Yogakey.toString())));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(yogasumlst[index].BackImg.toString())
                                                )
                                              ),
                                            ),
                                            Container(
                                              height: 200,
                                              color: Colors.black26,
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 10,
                                              top: 10,
                                              child: Text(yogasumlst[index].YogaWorkOutName, style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                              ),),
                                            ),
                                            Positioned(
                                              right: 20,
                                              left: 12,
                                              top: 38,
                                              child: Text(yogasumlst[index].TimeTaken, style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("https://c.ndtvimg.com/2022-05/pgo5us68_yoga-pose_625x300_04_May_22.jpg")
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          color: Colors.black26,
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text("Weight Loss Yoga", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),),
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 12,
                                          top: 38,
                                          child: Text("Last Time: 2 Feb", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("https://www.artofliving.org/sites/www.artofliving.org/files/styles/original_image/public/wysiwyg_imageupload/sun-salutation_0.jpg")
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          color: Colors.black26,
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text("Surya Salutation", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),),
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 12,
                                          top: 38,
                                          child: Text("Last Time: 2 Feb", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Choose Your Type", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("https://images.onlymyhealth.com//imported/images/2020/September/11_Sep_2020/big_yogaeveryday.jpg")
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          color: Colors.black26,
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text("Everyday Yoga challange", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),),
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 12,
                                          top: 38,
                                          child: Text("Last Time: 2 Feb", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("https://images.everydayhealth.com/images/stress-relief-yoga-legs-wall-22634112.jpg")
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          color: Colors.black26,
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text("Release Stress", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),),
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 12,
                                          top: 38,
                                          child: Text("Last Time: 2 Feb", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("https://wallpaperaccess.com/full/654400.jpg")
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          color: Colors.black26,
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 10,
                                          top: 10,
                                          child: Text("Meditation", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),),
                                        ),
                                        Positioned(
                                          right: 20,
                                          left: 12,
                                          top: 38,
                                          child: Text("Last Time: 2 Feb", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                          ),),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //  Comment-11 : Calling a CustomAppBar method
                  CustomAppBar(animationController: _animationController, colorTween: _colorTween, homeTween: _homeTween, yogaTween: _yogaTween, iconTween: _iconTween, drawerTween: _drawerTween, onPressed: (){scaffoldKey.currentState!.openDrawer();})
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}