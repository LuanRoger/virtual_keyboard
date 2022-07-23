import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

///Facade to handle Win32 INPUT information.
class KeyboardInput {
  late Pointer<INPUT> _input;
  Pointer<INPUT> get rawInput => _input;
  INPUT get inputInfo => _input.ref;

  KeyboardInput() {
    _input = calloc<INPUT>();
    ZeroMemory(_input, sizeOf<INPUT>());
    _input.ref.type = INPUT_KEYBOARD;
  }

  void dispose() {
    ZeroMemory(_input, sizeOf<INPUT>());
    free(_input);
  }
}
