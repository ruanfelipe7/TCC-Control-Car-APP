enum ControlMode { MANUAL, AUTOMATIC, COMMAND }

abstract class HomePresenter {

  Stream<String> get mainErrorStream;

  Stream<ControlMode> get controlModeStream;

  Future<void> connectBrokerMQTT();

  Future<void> publishTopic(String value);

  Future<void> activeAutonomousMode();

  Future<void> activeManualMode();

  Future<void> activeCommandMode();

  Stream<bool> get leftStream;

  Stream<bool> get rightStream;

  Stream<bool> get toBackStream;

  bool get isConnectedBroker;

  bool get hasError;

  void setMode(ControlMode control);

  void goFrontOrBack();

  void brake();

  void speedUp();

  void turnLeft();

  void turnRight();
  
  void commandTurnLeft();

  void commandTurnRight();

  void commandReturnByLeft();

  void commandReturnByRight();

  void commandSpeedUp();

  void commandSpeedDown();
}