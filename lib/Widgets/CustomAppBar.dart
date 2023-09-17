import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  AnimationController animationController;
  Animation colorTween, homeTween, yogaTween, iconTween, drawerTween;


  Function()? onPressed; // Comment-1 : This function is use to open the drawer(Hamburger).

  /*
  *  Comment-2 : Executed the above variables that's why we have to create a constructor and pass every variable as a named parameter
  *  using required keyword.
  */
  CustomAppBar({
  
    // Comment-3 :pass variable as a named parameter using `required` paramter.
    required this.animationController,
    required this.colorTween,
    required this.homeTween,
    required this.yogaTween,
    required this.iconTween,
    required this.drawerTween,
    required this.onPressed

  });

  @override
  Widget build(BuildContext context) {
    return Container(
    // Comment-4 : Now creating an App Bar
      height: 100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorTween.value,
          elevation: 0,
          title: Row(
            children: [
              Text("HOME ", style: TextStyle(
                color: homeTween.value,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              Text("YOGA", style: TextStyle(
                color: yogaTween.value,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),)  
            ]
          ),
          actions: [
            Icon(Icons.notifications, color: iconTween.value,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}