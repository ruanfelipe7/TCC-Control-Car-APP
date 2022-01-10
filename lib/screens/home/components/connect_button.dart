import 'package:flutter/material.dart';

import '../home.dart';

class ConnectButton extends StatelessWidget {
  final HomePresenter presenter;
  const ConnectButton({
    Key? key,
    required this.presenter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      
      child: Container(
        child: Text(
          'Conectar ao Broker MQTT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        height: 20,
        
      ),
      onPressed: () async {
        await presenter.connectBrokerMQTT();
      },
    );
  }
}
