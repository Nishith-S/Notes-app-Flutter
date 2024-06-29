import 'package:isar/isar.dart';

//this line is needed to generate file
//then run: dart run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id? id = Isar.autoIncrement; //start from 0 and 1,2,3... and so on
  late String? titleNote;
  late String? textNote; //will initialize later

  Note({
    this.id,
    this.titleNote,
    this.textNote,
  });
}

// class UserSettings {
//   bool isListView = true;
//   bool isDarkMode = true;
// }
