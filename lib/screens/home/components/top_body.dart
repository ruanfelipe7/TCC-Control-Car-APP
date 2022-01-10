import 'package:flutter/material.dart';

import '../home_presenter.dart';

class TopBody extends StatelessWidget {
  final HomePresenter presenter;
  final ControlMode controlMode;
  const TopBody({Key? key, required this.presenter, required this.controlMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ControlMode>(
        stream: presenter.controlModeStream,
        builder: (context, snapshot) {
          
          bool isManualMode = controlMode == ControlMode.MANUAL;
          bool isAutomaticMode = controlMode == ControlMode.AUTOMATIC;
          bool isCommandMode = controlMode == ControlMode.COMMAND;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image(
                    image: AssetImage('images/steering-wheel.png'),
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                decoration: BoxDecoration(
                  color: isManualMode ? Color(0xFF00BFFF) : Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Image(
                  image: AssetImage('images/autonomous-car.png'),
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                decoration: BoxDecoration(
                  color: isAutomaticMode ? Color(0xFF00BFFF) : Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Image(
                  image: AssetImage('images/remote-control.png'),
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                decoration: BoxDecoration(
                  color: isCommandMode ? Color(0xFF00BFFF) : Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
