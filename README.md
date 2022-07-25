# virtual_keyboard
### Simulate keystrokes with Win32 API.

## Features
- Simulate keystrokes.
- Press multiples keys with a determinated delay betwen them.
- Enable/Disable inputs from especific keyboard instance.

## Dependencies
- [win32](https://pub.dev/packages/win32)
- [ffi](https://pub.dev/packages/ffi)

## Example
This example writes keyboard with the 'o' being pressed for 30 milliseconds.
```dart
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
```

## Documentation
Access the documentation [here](https://github.com/LuanRoger/virtual_keyboard/wiki)