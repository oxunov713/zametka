import 'package:intl/intl.dart';

class Zametka implements Comparable<DateTime> {
  late final int _id;
  late String _title;
  late String _description;
  late bool isDone;
  late DateTime createdAt;
  late DateTime? updatedAt;

  Zametka({
    required int? id,
    required String? title,
    required String? description,
    required bool? isDone,
    required DateTime? createdAt,
    this.updatedAt,
  }) {
    _id = id ?? -1;
    this.title = title ?? "none";
    this.description = description ?? "none";
    this.isDone = isDone ?? false;
    this.createdAt = createdAt ?? DateTime.now();
  }

  Zametka copeWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Zametka(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get id => _id;

  set title(String title) {
    if (title.isEmpty) {
      print("Title is empty!");
      return;
    }
    _title = title;
  }

  String get title => _title;

  set description(String description) {
    if (description.isEmpty) {
      print("Description is empty!");
      return;
    }
    _description = description;
  }

  String get description => _description;

  @override
  int compareTo(DateTime other) {
    return createdAt.compareTo(other);
  }

  String getFormattedDate(DateTime? d) {
    if (d == null) {
      return "null";
    }
    DateFormat f = DateFormat('dd-MM-yyyy HH:mm:ss');
    return f.format(d).toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        isDone,
        createdAt,
      );

  @override
  bool operator ==(Object other) =>
      other is Zametka &&
      other.id == id &&
      other.title == title &&
      other.description == description;

  @override
  String toString() {
    return "$runtimeType(id: $id, title: $title, description: $description, isDone: $isDone, createdAt: ${getFormattedDate(createdAt)}, updatedAt:${getFormattedDate(updatedAt)})";
  }
}
