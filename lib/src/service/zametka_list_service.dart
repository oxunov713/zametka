import '../model/zametka.dart';
import '../repository/io_repository.dart';
import '../repository/zametka_repository.dart';

class ZametkaList implements ZametkaRepository {
  final List<Zametka> _zametkaList = [];
  final IIOService ioService;

  ZametkaList(this.ioService);

  @override
  void delete(Zametka zametka) {
    _zametkaList.remove(zametka);
  }

  @override
  void deleteById(int id) {
    checkZametkaList();
    _zametkaList.removeWhere((element) => element.id == id);
  }

  @override
  Zametka? findById(int id) {
    return _zametkaList.where((element) => element.id == id).first;
  }

  @override
  bool isExistById(int id) {
    for (int i = 0; i < _zametkaList.toList().length; i++) {
      if (_zametkaList.toList()[i].id == id) {
        return true;
      }
    }
    return false;
  }

  @override
  bool isExistByTitle(String title) {
    for (int i = 0; i < _zametkaList.toList().length; i++) {
      if (_zametkaList.toList()[i].title == title) {
        return true;
      }
    }
    return false;
  }

  @override
  void showList() {
    checkZametkaList();

    for (var element in _zametkaList) {
      ioService.write("$element \n");
    }
  }

  @override
  void sort(String sortType) {
    checkZametkaList();
    List<Zametka> zametkaList = _zametkaList.toList();
    if (sortType == "asc") {
      zametkaList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (sortType == "desc") {
      zametkaList.sort((b, a) => a.createdAt.compareTo(b.createdAt));
    }
    _showSortedList(zametkaList);
  }

  @override
  int maxId() {
    int result = 1;
    List<Zametka> zametkaList = _zametkaList.toList();
    zametkaList.sort((b, a) => a.createdAt.compareTo(b.createdAt));
    if (zametkaList.isNotEmpty) {
      result = zametkaList[0].id + 1;
    }
    return result;
  }

  @override
  void add(Zametka zametka) {
    _zametkaList.add(zametka);
  }

  @override
  noSuchMethod(Invocation invocation) {
    print("This method or property is not available!");
  }

  void _showSortedList(List<Zametka> list) {
    for (var element in list) {
      ioService.write("$element \n");
    }
  }

  void checkZametkaList() {
    if (_zametkaList.isEmpty) {
      ioService.write("Zametkalar mavjud emas!");
      return;
    }
  }
}
