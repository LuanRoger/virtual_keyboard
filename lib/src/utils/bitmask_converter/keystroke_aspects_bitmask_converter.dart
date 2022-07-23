import 'package:virtual_keyboard/src/enums/keystroke_aspects.dart';
import 'package:win32/win32.dart';

class KeystrokeAspectsBitmaskConverter {
  static convertAspect(KeystokeAspects keystokeAspects) {
    switch (keystokeAspects) {
      case KeystokeAspects.KEYEVENTF_EXTENDEDKEY:
        return KEYEVENTF_EXTENDEDKEY;
      case KeystokeAspects.KEYEVENTF_KEYUP:
        return KEYEVENTF_KEYUP;
      case KeystokeAspects.KEYEVENTF_SCANCODE:
        return KEYEVENTF_SCANCODE;
      case KeystokeAspects.KEYEVENTF_UNICODE:
        return KEYEVENTF_UNICODE;
    }
  }
}
