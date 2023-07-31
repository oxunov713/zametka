import 'dart:io';

import '../repository/io_repository.dart';

class IOService implements IIOService {
  const IOService();

  @override
  String read(String text) {
    print(text);
    return stdin.readLineSync() ?? "";
  }

  @override
  int readInt(String text) {
    print(text);
    return int.tryParse(stdin.readLineSync() ?? "") ?? 0;
  }

  @override
  void write(String text) {
    print(text);
  }
}
