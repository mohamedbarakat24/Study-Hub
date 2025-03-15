import 'package:isar/isar.dart';

// dart run build_runner build
part 'note_model.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
