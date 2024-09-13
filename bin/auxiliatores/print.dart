import 'package:dart_console/dart_console.dart';
class Print {
  static nota({required String nuntius, required String message}) {
    final console = Console();
    console.writeLine('nuntius: $nuntius', TextAlignment.center);
    console.writeLine('message: $message', TextAlignment.center);
  }
  static obstructionumReprobatus() {
    print('\n');
    print('corrumpere obstructionum deprehensis in sync');
    print('corrupt block detected upon sync');
  }

  static write(dynamic object) {
      print(' \n clientiswroteback \n ');
      print(object);
  }
  static wroteThrough(dynamic object) {
      print(' \n clientiswrotethrough \n ');
      print(object);
  }
}
