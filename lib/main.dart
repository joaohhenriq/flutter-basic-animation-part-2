import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Basic Animation p. 2',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  void mylistener(status){
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(mylistener);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn));

      animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(mylistener);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation 2"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Transform(
                transform: Matrix4.translationValues(
                    animation.value * width, 0.0, 0.0),
                child: Center(
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    color: Colors.green,
                  ),
                ),
              )),
    );
  }
}
