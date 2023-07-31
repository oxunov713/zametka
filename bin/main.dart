import 'package:zametka/zametka.dart';
void main(List<String> args) {
  final ioService = IOService();

  final lg = ZametkaLogic(
    zametkaList: ZametkaList(ioService),
    ioService: ioService,
  );

  lg.run();
}
