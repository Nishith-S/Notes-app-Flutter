/*
* In here, there will be all the operations that will perform on Isar DB
 */

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier {
  //Isar object
  static late Isar isar;
  //Initialize the DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //Need a list of notes
  List<Note> currentNote = [];
  List<Note> foundNote = [];

  //Create a note and save to DB
  Future<void> addNote(String title, String text) async {
    //new Note object and stored in newNote
    final newNote = Note()
      ..titleNote = title
      ..textNote = text;
    //write transaction
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from db by calling readNote method given below
    await readNote();
  }

  //Read a note from db
  Future<void> readNote() async {
    List<Note> readNotes = await isar.notes.where().findAll();
    currentNote.clear();
    currentNote.addAll(readNotes);
    notifyListeners();
  }

  //Update a note in db
  Future<void> updateNote(int? id, String newTitle, String? newText) async {
    final availableNotes = await isar.notes.get(id!);
    if (availableNotes != null) {
      availableNotes.titleNote = newTitle;
      availableNotes.textNote = newText;
      await isar.writeTxn(() => isar.notes.put(availableNotes));
    }
    await readNote();
  }

  //Delete a note from db
  Future<void> deleteNote(int? id) async {
    await isar.writeTxn(() => isar.notes.delete(id!));
    await readNote();
  }

  //run filter for searching
  Future runFilter(String enteredString) async {
    List<Note> result = [];
    if (enteredString.isNotEmpty) {
      result = currentNote
          .where((element) => element.titleNote!
              .toLowerCase()
              .contains(enteredString.toLowerCase()))
          .toList();
    } else {
      result = foundNote;
      await readNote();
    }
    foundNote = result;
    currentNote = foundNote;
    notifyListeners();
  }

  //save user settings
  Future<void> saveTheme(bool isDarkMode) async {
    // final gotTheme = isar.
  }
}
