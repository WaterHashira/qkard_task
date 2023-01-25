import 'dart:developer' as devtools show log;

// @github/rithik-dev
void log<T>({
  dynamic msg,
  dynamic error,
  String? id,
  StackTrace? stackTrace,
}) {
  devtools.log(
    msg.toString(),
    error: error,
    name: id ?? T.toString(),
    stackTrace: stackTrace,
  );
}

mixin Logger<T> {
  /// Logs a message
  void logMsg(dynamic msg) {
    log<T>(msg: msg.toString());
  }

  /// Logs an error
  void logErr(
    dynamic error, {
    StackTrace? stackTrace,
  }) {
    log<T>(
      msg: error,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
