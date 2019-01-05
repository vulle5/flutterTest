import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import '../funcs/mathConvert.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  // Declaring animation variable and animation controller
  // and their types
  // Animation stores current values of the animation
  Animation<double> catAnimation;
  // AnimationController controls animation like starting and stoping it
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  // Method that gives intial values for the state
  @override
  void initState() {
    // @mustCallSuper
    super.initState();

    // Here we initialize the catContoller 
    catController = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      // vsync is required and needs a TickerProvider that is a mixin
      // so by calling 'this' we tell vsync that TickerProvider is mixed in
      // with our instance of this class
      vsync: this,
    );

    // Intialzing Animation with Tween that describes the range
    // of value that the animation spans
    catAnimation = Tween(begin: -35.0, end: -80.0)
    // Tween.animate takes what type of animation we want
    // in this case we use CurvedAnimation with easeIn curve
    .animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      )
    );

    boxController = AnimationController(
      duration: Duration(
        milliseconds: 300,  
      ),
      vsync: this,
    );
    // My custom function to convert degrees to rad VVVV
    boxAnimation = Tween(begin: degToRad(110.0), end: degToRad(125.0)).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      )
    );
    // Will be called if Animation has certain status
    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
  }

  // Helper functon to call when user taps the cat
  onTap() {
    // if catAnimation is already completed reverse the animation
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      // When cat is NOT inside the box stop the flaps
      boxController.stop();
      // This starts the animation
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Box'),       
      ),
      // GestureDetector to detect when we tap the cat picture
      body: GestureDetector(
        child: Center(
          child: Stack(
            // Overflow will allow Positioned Widgets to go outside
            // the stack boundaries
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      )
    );
  }
  
  Widget buildCatAnimation() {
    // AnimationBuilder re-renders every tick of the animation
    // We pass in the animation and the controller so builder knows
    // what to animate
    return AnimatedBuilder(
      animation: catAnimation,
      // We do not want to re-render the whole cat picture every
      // 16.6 milliseconds. To save performance we want to only change
      // some of the values of the cat like it's position on the screen
      // for that reason we have the child property
      builder: (context, child) {
        // Positioned will be re-rendered completely every time, but
        // Positioned is very inexpensive to create so that does not really matter
        // Cat class on the other hand which is inside a child property only get's
        // created once so we do not have to make that network call every time we re-render
        // (16.6 millisenconds, 60fps) on normal phone screen
        return Positioned(
          child: child,
          // We increase the bottom acording to the Animation class value
          // Animation class contains the values for the animation
          // !!!!Remeber!!!! Animaton class has no idea what we want to do to the picture
          // so we need to apply the animation.value to some positional Widget like
          // EdgeInsets
          top: catAnimation.value,
          // Limiting cat's size
          left: 0.0,
          right: 0.0,
        );
      },
      // Single instance of the cat picture
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        // Transform.rotate rotates it's child
        child: Container (
          height: 10.0,
          width: 100.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            // The point that the rotate is applied around
            alignment: Alignment.topLeft,
          );
        }
      ),
    );
  }

  // RightFlap uses same animation conroller and animation as left one
  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        // Transform.rotate rotates it's child
        child: Container (
          height: 10.0,
          width: 100.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            // Negative animation value
            angle: -boxAnimation.value,
            // The point that the rotate is applied around
            alignment: Alignment.topRight,
          );
        }
      ),
    );
  }
}