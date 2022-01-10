import 'package:flutter/material.dart';

class AutonomousMode extends StatefulWidget {
  const AutonomousMode({Key? key}) : super(key: key);

  @override
  _AutonomousModeState createState() => _AutonomousModeState();
}

class _AutonomousModeState extends State<AutonomousMode> {
  bool left = false;
  bool right = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              left ? 'images/left-arrow-gif.gif' : 'images/left-arrow.png',
            ),
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          SizedBox(
            width: 5,
          ),
          Image(
            image: AssetImage('images/volante.gif'),
            height: MediaQuery.of(context).size.height * 0.65,
          ),
          Image(
            image: AssetImage('images/cambio.gif'),
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Image(
              image: AssetImage('images/pedais.gif'),
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          SizedBox(
            width: 10,
          ),
          Image(
            image: AssetImage(
              right ? 'images/right-arrow-gif.gif' : 'images/right-arrow.png',
            ),
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }
}
