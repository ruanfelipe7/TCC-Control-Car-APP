import 'package:flutter/material.dart';

import '../home_presenter.dart';

class CommandMode extends StatefulWidget {
  final HomePresenter presenter;
  const CommandMode({Key? key, required this.presenter}) : super(key: key);

  @override
  _CommandModeState createState() => _CommandModeState();
}

class _CommandModeState extends State<CommandMode> {
  num degree = 0;
  num factorWidth = 0.16; 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * factorWidth,
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage('images/turn-left.png'),
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    onTap: () {
                      widget.presenter.commandTurnLeft();
                      setState(() {
                        degree -= 90;
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(degree / 360),
                  child: Image(
                    image: AssetImage('images/top-view-car.png'),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * factorWidth,
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage('images/turn-right.png'),
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    onTap: () {
                      widget.presenter.commandTurnRight();
                      setState(() {
                        degree += 90;
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * factorWidth,
                child: GestureDetector(
                  child: Image(
                    image: AssetImage('images/turn-back-left.png'),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  onTap: () {
                    widget.presenter.commandReturnByLeft();
                    setState(() {
                      degree -= 180;
                    });
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(150),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * factorWidth,
                child: GestureDetector(
                  child: Image(
                    image: AssetImage('images/down-arrow.png'),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  onTap: () {
                    widget.presenter.commandSpeedDown();
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(150),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * factorWidth,
                child: GestureDetector(
                  child: Image(
                    image: AssetImage('images/up-arrow.png'),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  onTap: () {
                    widget.presenter.commandSpeedUp();
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(150),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * factorWidth,
                child: GestureDetector(
                  child: Image(
                    image: AssetImage('images/turn-back.png'),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  onTap: () {
                    widget.presenter.commandReturnByRight();
                    setState(() {
                      degree += 180;
                    });
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(150),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
