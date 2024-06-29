import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_db.dart';
import 'package:notes/pages/text_editing_page.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import '../components/appbar_menu_items.dart';
import '../components/mydrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //object of note_db
  NoteDataBase noteDataBase = NoteDataBase();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  //boolean to have a message when there is no note
  bool haveNote() {
    final foundNotee =
        Provider.of<NoteDataBase>(context, listen: false).currentNote;
    if (foundNotee.isNotEmpty) {
      return true;
    }
    return false;
  }

  createANote() {
    int id = Provider.of<NoteDataBase>(context, listen: false)
        .readNote()
        .toString()
        .length;
    //a blank note
    Note newNote = Note(
      id: id,
      titleNote: "",
      textNote: "",
    );
    //go to note editing page
    goToNoteEditPage(newNote, true);
  }

  goToNoteEditPage(Note note, bool isNewNote) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TextEditingPage(
          note: note,
          isNewNote: isNewNote,
          id: note.id,
          titleNote: note.titleNote,
          textNote: note.textNote,
        ),
      ),
    );
  }

  //read a note
  void readNotes() {
    Provider.of<NoteDataBase>(context, listen: false).readNote();
  }

  updateNote(Note note, int? id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TextEditingPage(
          note: note,
          isNewNote: false,
          id: id,
          titleNote: note.titleNote,
          textNote: note.textNote,
        ),
      ),
    );
  }

  //delete a note
  deleteNote(int? id) {
    try {
      context.read<NoteDataBase>().deleteNote(id!);
      Fluttertoast.showToast(
        msg: "Note deleted!",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      readNotes();
      setState(() {});
    } on RangeError catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong...",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }
  }

  void runFilter(String enteredString) {
    setState(() {
      Provider.of<NoteDataBase>(context, listen: false)
          .runFilter(enteredString);
    });
  }

  //boolean for searchbar
  bool isSearchOpen = false;

  //boolean for gird view and listview
  bool isListView = false;

  //handle refresh
  Future _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    readNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final noteDB = context.watch<NoteDataBase>();
    List<Note> currentNote = noteDB.currentNote.reversed.toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: !isSearchOpen ? 0 : 25,
        backgroundColor: Colors.transparent,
        title: !isSearchOpen
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 15),
                child: TextField(
                  autofocus: true,
                  onChanged: (value) => runFilter(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search notes by title...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSearchOpen = !isSearchOpen;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: !isSearchOpen
                  ? const Icon(Icons.search)
                  : const Text("Cancel"),
            ),
          ),
          SizedBox(
            child: !isSearchOpen
                ? Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showPopover(
                        height: 80,
                        width: 130,
                        direction: PopoverDirection.bottom,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        context: context,
                        bodyBuilder: (BuildContext context) {
                          return AppBarMenu(
                            onTap: () {
                              setState(() {
                                isListView = !isListView;
                                Navigator.of(context).pop();
                              });
                            },
                            child: isListView
                                ? const Text(
                                    "Grid view",
                                  )
                                : const Text(
                                    "List view",
                                  ),
                          );
                        },
                      ),
                      icon: const Icon(Icons.more_vert),
                    );
                  })
                : null,
          )
        ],
      ),
      drawer: !isSearchOpen ? const MyDrawer() : null,
      body: RefreshIndicator(
        edgeOffset: 2.0,
        key: _refreshIndicatorKey,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        color: Theme.of(context).colorScheme.background,
        onRefresh: _handleRefresh,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Notes",
                style: GoogleFonts.dmSerifText(fontSize: 38),
              ),
            ),
            if (haveNote())
              Expanded(
                child: isListView
                    ? Container(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          reverse: false,
                          itemCount: currentNote.length,
                          itemBuilder: (context, index) {
                            final note = currentNote[index];
                            return GestureDetector(
                              onLongPress: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200,
                                        width: 250,
                                        child: CupertinoActionSheet(
                                          title: const Text("Notes"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  deleteNote(note.id);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 0, left: 18, right: 18),
                                child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: CupertinoListTile(
                                      onTap: () {
                                        updateNote(note, note.id);
                                      },
                                      title: Text(
                                        note.titleNote.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary),
                                      ),
                                      subtitle: Text(
                                        note.textNote.toString(),
                                        style: TextStyle(
                                            fontSize: 15.7,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary),
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                      )
                    : MasonryGridView.builder(
                        reverse: false,
                        itemCount: currentNote.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          Provider.of<NoteDataBase>(context, listen: false)
                                  .foundNote
                                  .reversed
                                  .toList();
                          final note = currentNote[index];
                          return GestureDetector(
                            onTap: () => updateNote(note, note.id),
                            onLongPress: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: CupertinoActionSheet(
                                        title: const Text("Notes"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                deleteNote(note.id);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: const Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.5),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 25),
                                  child: Column(
                                    children: [
                                      Text(
                                        note.titleNote.toString(),
                                        overflow: TextOverflow.values[2],
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        note.textNote.toString(),
                                        overflow: TextOverflow.values[2],
                                        style: const TextStyle(
                                          fontSize: 15.7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            else
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "No notes",
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: !isSearchOpen
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 68,
                width: 68,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FloatingActionButton(
                    onPressed: createANote,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.save,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
