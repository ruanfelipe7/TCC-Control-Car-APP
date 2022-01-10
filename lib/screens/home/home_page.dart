import 'package:carcontrolapp/screens/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import '../../presenter/home/home.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter = StreamHomePresenter();
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool autonomousMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(children: [
            Text('Control Car APP'),
            SizedBox(
              width: 10,
            ),
            Icon(
              widget.presenter.isConnectedBroker
                  ? Icons.signal_wifi_4_bar_rounded
                  : Icons.signal_wifi_off_rounded,
            ),
          ]),
        ),
        actions: _buildActions(),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<ControlMode>(
              stream: widget.presenter.controlModeStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                //bool isManualMode = snapshot.data == ControlMode.MANUAL;
                bool isAutomaticMode = snapshot.data == ControlMode.AUTOMATIC;
                bool isCommandMode = snapshot.data == ControlMode.COMMAND;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopBody(
                      presenter: widget.presenter,
                      controlMode: isAutomaticMode
                          ? ControlMode.AUTOMATIC
                          : isCommandMode
                              ? ControlMode.COMMAND
                              : ControlMode.MANUAL,
                    ),
                    isAutomaticMode
                        ? AutonomousMode()
                        : isCommandMode
                            ? CommandMode(
                                presenter: widget.presenter,
                              )
                            : ManualMode(
                                presenter: widget.presenter,
                              ),
                  ],
                );
              }),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buildActions() {
    return [
      PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          List<String> items = [
            'Conectar ao Broker MQTT',
            'Modo Manual',
            'Modo Automático',
            'Modo de Comandos'
          ];
          return items.map(
            (String option) {
              return PopupMenuItem<String>(
                child: Text(option),
                value: option,
              );
            },
          ).toList();
        },
        onSelected: (String option) {
          _handleActions(option, context);
        },
      )
    ];
  }

  void _handleActions(String option, BuildContext context) async {
    switch (option) {
      case 'Conectar ao Broker MQTT':
        await widget.presenter.connectBrokerMQTT();
        if (!widget.presenter.hasError) {
          showSuccessMessage('Conectado com sucesso');
          Future.delayed(Duration(seconds: 3), () async {
            Navigator.pop(context);
          });
          setState(() {});
        } else {
          showFailMessage('Falha ao se conectar');
          Future.delayed(Duration(seconds: 3), () async {
            Navigator.pop(context);
          });
        }

        break;
      case 'Modo Manual':
        widget.presenter.activeManualMode();
        break;
      case 'Modo Automático':
        widget.presenter.activeAutonomousMode();
        break;
      case 'Modo de Comandos':
        widget.presenter.activeCommandMode();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      widget.presenter.setMode(ControlMode.MANUAL);
    });
  }

  Widget _buildLoad(String message, IconData icon) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          Icon(icon),
          Container(
            child: Text(message),
            margin: EdgeInsets.only(left: 15),
          ),
        ],
      ),
    );
    return alert;
  }

  void showSuccessMessage(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _buildLoad(message, Icons.check_circle);
      },
    );
  }

  void showFailMessage(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _buildLoad(message, Icons.error);
      },
    );
  }
}
