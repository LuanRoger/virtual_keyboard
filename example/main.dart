import 'package:virtual_keyboard/virtual_keyboard.dart';

void main() async {
  Keyboard mainKeyboard = Keyboard();
  mainKeyboard.press(KeyboardKey.K);
  mainKeyboard.press(KeyboardKey.E);
  mainKeyboard.press(KeyboardKey.Y);
  mainKeyboard.press(KeyboardKey.B);
  await mainKeyboard.pressAndHold(
      KeyboardKey.O, const Duration(milliseconds: 30));
  mainKeyboard.press(KeyboardKey.A);
  mainKeyboard.press(KeyboardKey.R);
  mainKeyboard.press(KeyboardKey.D);
}
