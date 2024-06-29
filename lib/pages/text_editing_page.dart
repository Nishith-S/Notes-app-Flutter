import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/models/note_db.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextEditingPage extends StatefulWidget {
  final Note note;
  final bool isNewNote;
  final int? id;
  final String? titleNote;
  final String? textNote;

  const TextEditingPage({
    super.key,
    required this.note,
    required this.isNewNote,
    required this.id,
    this.titleNote,
    this.textNote,
  });

  @override
  State<TextEditingPage> createState() => _TextEditingPageState();
}

class _TextEditingPageState extends State<TextEditingPage> {
  final QuillController _quillController = QuillController.basic();
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  bool haveText() {
    setState(() {});
    if (titleController.text.isNotEmpty &&
        _quillController.document.toPlainText().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  addNote() {
    if (titleController.text.toString().isEmpty ||
        textController.text.toString().isEmpty) {
      Fluttertoast.showToast(
        msg: "Empty note discarded!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      Navigator.of(context).pop();
    } else {
      context
          .read<NoteDataBase>()
          .addNote(titleController.text, textController.text);
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Note created!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }
  }

  updateNote() {
    if (titleController.text.toString().isEmpty ||
        textController.text.toString().isEmpty) {
      context.read<NoteDataBase>().deleteNote(widget.id);
      Fluttertoast.showToast(
        msg: "Empty note discarded!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      Navigator.of(context).pop();
    } else {
      context
          .read<NoteDataBase>()
          .updateNote(widget.id, titleController.text, textController.text);
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Note updated!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }
  }

  loadExistingNote() {
    setState(() {
      titleController.text = widget.note.titleNote!;
      textController.text = widget.note.textNote!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          tooltip: "Back",
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (widget.isNewNote) {
                  addNote();
                } else {
                  updateNote();
                }
              });
            },
            child: Text(
              "Save",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: TextField(
                      cursorColor: Theme.of(context).colorScheme.inversePrimary,
                      style: const TextStyle(fontSize: 28),
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Heading",
                        hintStyle: TextStyle(fontSize: 28),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 15),
                    child: TextField(
                      maxLines: 50000,
                      autofocus: true,
                      showCursor: true,
                      cursorColor: Theme.of(context).colorScheme.inversePrimary,
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
