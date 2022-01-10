import 'package:flutter/material.dart';

import '../home_presenter.dart';

class ManualMode extends StatefulWidget {
  final HomePresenter presenter;
  const ManualMode({Key? key, required this.presenter}) : super(key: key);

  @override
  _ManualModeState createState() => _ManualModeState();
}

class _ManualModeState extends State<ManualMode> {
  num heightAccel = 0.4;
  num heightBrake = 0.4;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder<bool>(
            stream: widget.presenter.leftStream,
            builder: (context, snapshot) {
              bool left = false;
              if (snapshot.hasData) {
                left = snapshot.data!;
              }
              return Image(
                image: AssetImage(
                  left ? 'images/left-arrow-gif.gif' : 'images/left-arrow.png',
                ),
                height: MediaQuery.of(context).size.height * 0.15,
              );
            }),
        SizedBox(
          width: 5,
        ),
        Row(
          children: [
            GestureDetector(
              child: Image(
                image: AssetImage('images/volante-esquerda.png'),
                height: MediaQuery.of(context).size.height * 0.65,
              ),
              onTap: () async {
                widget.presenter.turnLeft();
              },
            ),
            GestureDetector(
              child: Image(
                image: AssetImage('images/volante-direita.png'),
                height: MediaQuery.of(context).size.height * 0.65,
              ),
              onTap: () {
                widget.presenter.turnRight();
              },
            ),
          ],
        ),
        StreamBuilder<bool>(
            stream: widget.presenter.toBackStream,
            builder: (context, snapshot) {
              bool toBack = false;
              if (snapshot.hasData) {
                toBack = snapshot.data!;
              }
              return GestureDetector(
                child: Image(
                  image: AssetImage(toBack
                      ? 'images/gearshift.png'
                      : 'images/gearshift2.png'),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                onTap: () {
                  widget.presenter.goFrontOrBack();
                },
              );
            }),
        GestureDetector(
          child: Image(
            image: AssetImage('images/brake-pedal.png'),
            height: MediaQuery.of(context).size.height * heightBrake,
          ),
          onTapDown: (details) {
            setState(() {
              heightBrake = 0.38;
            });
            widget.presenter.brake();
          },
          onTapUp: (details) {
            setState(() {
              heightBrake = 0.4;
            });
          },
        ),
        GestureDetector(
          child: Image(
            image: AssetImage('images/accel-pedal.png'),
            height: MediaQuery.of(context).size.height * heightAccel,
          ),
          onTapDown: (details) {
            setState(() {
              heightAccel = 0.38;
            });
            widget.presenter.speedUp();
          },
          onTapUp: (details) {
            setState(() {
              heightAccel = 0.4;
            });
          },
        ),
        SizedBox(
          width: 10,
        ),
        StreamBuilder<bool>(
            stream: widget.presenter.rightStream,
            builder: (context, snapshot) {
              bool right = false;
              if (snapshot.hasData) {
                right = snapshot.data!;
              }
              return Image(
                image: AssetImage(
                  right
                      ? 'images/right-arrow-gif.gif'
                      : 'images/right-arrow.png',
                ),
                height: MediaQuery.of(context).size.height * 0.15,
              );
            }),
      ],
    );
  }
}
