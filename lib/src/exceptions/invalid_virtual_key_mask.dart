import 'package:virtual_keyboard/src/enums/keyboard_key.dart';

class InvalidVirtualKeyMask implements Exception {
  final KeyboardKey _invalidKey;
  String get _message =>
      "The key $_invalidKey has not been defined in bitmask.";

  InvalidVirtualKeyMask(this._invalidKey);

  @override
  String toString() => _message;
}
