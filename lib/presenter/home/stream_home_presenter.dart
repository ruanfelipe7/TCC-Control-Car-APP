import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:mqtt_client/mqtt_client.dart' show MqttClientPayloadBuilder, MqttConnectMessage, MqttQos;
// ignore: import_of_legacy_library_into_null_safe
import 'package:mqtt_client/mqtt_server_client.dart' show MqttServerClient;
import '../../screens/home/home.dart';

const String topicMqttControl = '4361fd9a-0c1e-420c-b858-27ad478288e6/controlCar';

class HomeState {
   late MqttServerClient clientMqtt;

   bool toBack = false;

   bool left = false;

   bool right = false;

   bool connected = false;

   ControlMode controlMode = ControlMode.MANUAL;

   String mainError = '';
}

class StreamHomePresenter implements HomePresenter{
  StreamController<HomeState> _controller =
      StreamController<HomeState>.broadcast();
  HomeState _state = HomeState();

  Stream<MqttServerClient> get clientMqttStream =>
      _controller.stream.map((state) => state.clientMqtt).distinct();

  Stream<bool> get toBackStream =>
      _controller.stream.map((state) => state.toBack).distinct();

  Stream<ControlMode> get controlModeStream =>
      _controller.stream.map((state) => state.controlMode).distinct();

  Stream<bool> get leftStream =>
      _controller.stream.map((state) => state.left).distinct();
  
  Stream<bool> get rightStream =>
      _controller.stream.map((state) => state.right).distinct();

  Stream<String> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();

  bool get isConnectedBroker => _state.connected;

  bool get hasError => _state.mainError != '';
  
  @override
  Future<void> connectBrokerMQTT() async {
    MqttServerClient client =
      MqttServerClient.withPort('broker.mqtt-dashboard.com', 'flutter_client', 1883);
  client.logging(on: true);
  client.onConnected = _onConnected;
  client.onDisconnected = _onDisconnected;
  client.onUnsubscribed = _onUnsubscribed;
  client.onSubscribed = _onSubscribed;
  client.onSubscribeFail = _onSubscribeFail;
  client.pongCallback = _pong;

  try {
    await client.connect();
    _state.connected = true;
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
    _state.connected = false;
    _state.mainError = 'Erro ao conectar o broker MQTT';
    _update();
  }

  _state.clientMqtt = client;
  _update();

  }

  @override
  Future<void> publishTopic(String value) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(value);
    _state.clientMqtt.publishMessage(topicMqttControl, MqttQos.atLeastOnce, builder.payload);
  }

  // The connection was successful
  void _onConnected() {
    print('Connected');
  }

// Disconnection
  void _onDisconnected() {
    print('Disconnected');
  }

// Subscription to topic succeeded
  void _onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// Failed to subscribe to topic
  void _onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// Unsubscribed successfully
  void _onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void _pong() {
    print('Ping response client callback invoked');
  }

  void _update() => _controller.add(_state);

  @override
  void brake() {
    _clearLeftRight();
    publishTopic("000");
  }


  @override
  void goFrontOrBack() {
    _state.toBack = !_state.toBack;
    _update();
  }

  @override
  void speedUp() {
    _clearLeftRight();
    publishTopic( _state.toBack ? '111' : '101');
  }

  @override
  void turnLeft() {
    _clearLeftRight();
    _state.left = true;
    _update();
    publishTopic( _state.toBack ? '110' : '100'); 
  }

  @override
  void turnRight() {
    _clearLeftRight();
    _state.right = true;
    _update();
    publishTopic( _state.toBack ? '011' : '001');
  }

  void _clearLeftRight(){
    _state.left = false;
    _state.right = false;
    _update();
  }

  @override 
  void setMode(ControlMode control){
    _state.controlMode = control;
    _update();
  }

  @override
  Future<void> activeAutonomousMode() async {
    publishTopic('A');
    setMode(ControlMode.AUTOMATIC);
  }

  @override
  Future<void> activeManualMode() async {
    publishTopic('M');
    setMode(ControlMode.MANUAL);
  }

  @override
  Future<void> activeCommandMode() async {
    publishTopic('C');
    _state.toBack = false;
    setMode(ControlMode.COMMAND);
  }

  @override
  void commandTurnLeft() {
    publishTopic('100');
  }

  @override
  void commandTurnRight() {
    publishTopic('001');
  }

  @override
  void commandReturnByLeft() {
    publishTopic('110');
  }

  @override
  void commandReturnByRight() {
    publishTopic('011');
  }

  @override
  void commandSpeedUp() {
    publishTopic('111');
  }

  @override
  void commandSpeedDown() {
    publishTopic('010');
  }
  
}