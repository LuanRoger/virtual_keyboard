import 'dart:ffi';
import 'package:virtual_keyboard/src/models/keyboard_input.dart';
import 'package:virtual_keyboard/src/utils/bitmask_converter/keyboard_key_bitmask_converter.dart';
import 'package:virtual_keyboard/src/utils/bitmask_converter/keystroke_aspects_bitmask_converter.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:win32/win32.dart';

/// Use ```Keyboard``` to simulate keystrokes.
/// Example:
/// ```dart
/// Keyboard keyboard = Keyboard();
/// mainKeyboard.press(KeyboardKey.H);
/// mainKeyboard.press(KeyboardKey.E);
/// mainKeyboard.press(KeyboardKey.L);
/// mainKeyboard.press(KeyboardKey.L);
/// mainKeyboard.press(KeyboardKey.O);
/// ```
/// 
/// Use ```enable``` property to enable/disable the keyboard,
/// that way, the keyboard cant press any key.
class Keyboard {
  bool enabled;

  Keyboard({this.enabled = true});

  ///Simualte a keystroke.
  ///
  ///```keyInput``` - Key to be pressed.
  void press(KeyboardKey keyInput) {
    if (!enabled) return;

    KeyboardInput input = KeyboardInput();

    int? virtualKeyMask =
        KeyboardKeyBitmaskConverter.convertKeyboardKey(keyInput);
    if (virtualKeyMask == null) throw InvalidVirtualKeyMask(keyInput);

    input.inputInfo.ki.wVk = virtualKeyMask;

    SendInput(INPUT_KEYBOARD, input.rawInput, sizeOf<INPUT>());

    _releaseButton(input);
  }

  ///Simulate a keystroke a few times.
  ///
  ///```keyInput``` - Key to be pressed.
  ///```pressTimes``` - Times to press the key.
  void pressTimes(KeyboardKey keyInput, int pressTimes) {
    if (!enabled) return;

    KeyboardInput input = KeyboardInput();

    int? virtualKeyMask =
        KeyboardKeyBitmaskConverter.convertKeyboardKey(keyInput);
    if (virtualKeyMask == null) throw InvalidVirtualKeyMask(keyInput);

    input.inputInfo.ki.wVk = virtualKeyMask;

    for (int times = 0; times <= pressTimes; times++) {
      SendInput(INPUT_KEYBOARD, input.rawInput, sizeOf<INPUT>());
    }

    _releaseButton(input);
  }

  ///Simualte a keystroke and hold the key until the duration ends.
  ///
  ///```keyInput``` - Key to be pressed.
  ///```duration``` - Define a duration to until release.
  Future pressAndHold(KeyboardKey keyInput, Duration duration) async {
    if (!enabled) return;

    KeyboardInput input = KeyboardInput();

    int? virtualKeyMask =
        KeyboardKeyBitmaskConverter.convertKeyboardKey(keyInput);
    if (virtualKeyMask == null) throw InvalidVirtualKeyMask(keyInput);

    input.inputInfo.ki.wVk = virtualKeyMask;

    await Future.doWhile(() {
      Stopwatch holdTimer = Stopwatch();
      holdTimer.start();

      while (duration.compareTo(holdTimer.elapsed) > 0) {
        SendInput(INPUT_KEYBOARD, input.rawInput, sizeOf<INPUT>());
      }

      return false;
    });

    _releaseButton(input);
  }

  ///Release all holding buttons.
  void _releaseButton(KeyboardInput input) {
    input.inputInfo.ki.dwFlags = KeystrokeAspectsBitmaskConverter.convertAspect(
        KeystokeAspects.KEYEVENTF_KEYUP);
    SendInput(INPUT_KEYBOARD, input.rawInput, sizeOf<INPUT>());
    input.dispose();
  }
}
