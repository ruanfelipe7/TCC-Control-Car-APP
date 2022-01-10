import 'package:flutter/material.dart';

import '../home.dart';

class RightButton extends StatelessWidget {
  final String title;
  final HomePresenter presenter;
  const RightButton({
    Key? key,
    required this.title,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        height: 20,
        
      ),
      onPressed: () {
        presenter.turnRight();
      },
    );
  }
}
