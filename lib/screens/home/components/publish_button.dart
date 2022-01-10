import 'package:flutter/material.dart';

import '../home.dart';

class PublishButton extends StatelessWidget {
  final String title;
  final HomePresenter presenter;
  final String message;
  const PublishButton({
    Key? key,
    required this.title,
    required this.presenter,
    required this.message,
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
        presenter.publishTopic(message);
      },
    );
  }
}
