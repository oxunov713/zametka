import '../model/zametka.dart';
import '../repository/io_repository.dart';
import '../repository/zametka_repository.dart';

class ZametkaLogic {
  final IIOService ioService;
  ZametkaRepository zametkaList;

  ZametkaLogic({
    required this.zametkaList,
    required this.ioService,
  });

  void run() {
    while (true) {
      ioService.write(
        "----------Zametka menu----------\n"
        "1. Zametka yaratish\n"
        "2. Zametkalarni ko'rish\n"
        "3. Zametkani taxrirlash\n"
        "4. Zametka o'chirish\n"
        "5. Zametkalarni saralash\n"
        "6. Bajarilgan sifatida belgilash\n"
        "7. Chiqish",
      );
      String text = ioService.read("Bajarmoqchi bo'lgan amalingizning tartib raqamini kiriting: ");
      done(text);
      if (text.trim() == "7") {
        break;
      }
    }
  }

  void done(String text) {
    switch (text.trim()) {
      case "1":
        createZametka();
        break;
      case "2":
        zametkaList.showList();
        break;
      case "3":
        updateZametka();
        break;
      case "4":
        deleteZametka();
        break;
      case "5":
        sortZametka();
        break;
      case "6":
        signAsDone();
        break;
    }
  }

  void createZametka() {
    String title = ioService.read("Zametka nomini kiriting: ");
    if (title.isEmpty) {
      ioService.write("Zametka nomi bo'sh bo'lmasligi kerak!");
      return;
    }
    if (zametkaList.isExistByTitle(title.trim())) {
      ioService.write("Bunday nomga ega zametka mavjud!");
      return;
    }
    String description = ioService.read("Tasnifini kiriting: ");
    if (description.isEmpty) {
      ioService.write("Zametka tasnifi bo'sh bo'lmasligi kerak!");
      return;
    }
    Zametka z = Zametka(
      id: zametkaList.maxId(),
      title: title.trim(),
      description: description.trim(),
      isDone: false,
      createdAt: DateTime.now(),
    );
    zametkaList.add(z);
  }

  void updateZametka() {
    int id = ioService.readInt("Taxrirlamoqchi bo'lgan zametkaning id isini kiritg: ");
    Zametka? z;

    if (zametkaList.isExistById(id)) {
      z = zametkaList.findById(id);
    }
    if (z == null) {
      ioService.write("Bunday zametka mavjud emas!");
      return;
    } else {
      String title =
          ioService.read("Zametkaning yangi nomini kiriting (${z.title} o'zgarishsiz qolishi uchun enter tugmasini bosing)");
      if (zametkaList.isExistByTitle(title.trim())) {
        ioService.write("Bunday nomga ega zametka mavjud!");
        return;
      }
      String description = ioService.read(
          "Zametkaning yangi tasnifini kiriting (${z.description.substring(0, z.description.length ~/ 2 + 1)}... o'zgarishsiz qolishi uchun enter tugmasini bosing)");
      if (title.isNotEmpty) {
        z.title = title;
      }
      if (description.isNotEmpty) {
        z.description = description;
      }
      if (title.isEmpty && description.isEmpty) {
        ioService.write("Zametkani taxrirlash uchun ma'lumot kiritilmadi!");
        return;
      }
      z.updatedAt = DateTime.now();
      //zametkaList.update(z);
      ioService.write("${z.id} id ga ega zametka muvoffaqiyatli taxrirlandi!");
    }
  }

  void deleteZametka() {
    int id = ioService.readInt("O'chirmoqchi bo'lgan zametkaning id isini kiritg: ");
    if (zametkaList.isExistById(id)) {
      Zametka? z = zametkaList.findById(id);
      if (z == null) {
        ioService.write("Bunday zametka mavjud emas!");
        return;
      }
      zametkaList.delete(z);
      ioService.write("$id id ga ega zametka muvoffaqiyatli o'chirildi!");
    } else {
      ioService.write("Bunday zametka mavjud emas!");
      return;
    }
  }

  void sortZametka() {
    String sortType = ioService.read(
      "Zametkaning yaratilgan vaqti bo'yich saralash\n"
      "1. O'sish tartibida\n"
      "2. Kamayish tartibida",
    );
    switch (sortType.trim()) {
      case "1":
        zametkaList.sort("asc");
        break;
      case "2":
        zametkaList.sort("desc");
        break;
    }
  }

  void signAsDone() {
    int id = ioService.readInt("Zametkaning id isini kiriting:");
    Zametka? z;

    if (zametkaList.isExistById(id)) {
      z = zametkaList.findById(id);
    }
    if (z == null) {
      ioService.write("Bunday zametka mavjud emas!");
      return;
    }
    int isDoneId = ioService.readInt(
      "Zametkaning bajarilgan xolatini belgilash\n"
      "1. Bajarilgan sifatida\n"
      "2. Bajarilmagan sifatida",
    );
    switch (isDoneId) {
      case 1:
        z.isDone = true;
        break;
      case 2:
        z.isDone = false;
        break;
    }
    z.updatedAt = DateTime.now();
    //zametkaList.update(z);
  }
}
