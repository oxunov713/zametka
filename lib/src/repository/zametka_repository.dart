import '../model/zametka.dart';

abstract interface class ZametkaRepository {
  void deleteById(int id);

  void delete(Zametka zametka);

  void showList();

  void sort(String sortType);

  Zametka? findById(int id);

  void update(Zametka zametka);

  int maxId();

  void add(Zametka zametka);

  bool isExistById(int id);

  bool isExistByTitle(String title);
}
