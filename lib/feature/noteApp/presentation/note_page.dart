import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:study_hub/core/constants/colors.dart';
import 'package:study_hub/feature/noteApp/data/models/note_database.dart';
import 'package:study_hub/feature/noteApp/data/models/note_model.dart';

class NotePages extends StatefulWidget {
  const NotePages({super.key});

  @override
  State<NotePages> createState() => _NotePagesState();
}

class _NotePagesState extends State<NotePages> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void openNoteBottomSheet({Note? note}) {
    if (note != null) {
      textController.text = note.text;
    } else {
      textController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 10,
          ),
          decoration: BoxDecoration(
            color: MyColors.softGrey,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 4,
                  margin: const EdgeInsets.only(top: 2, bottom: 16),
                  decoration: BoxDecoration(
                    color: MyColors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Enter Note",
                    hintStyle: TextStyle(color: MyColors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: MyColors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (note != null) {
                        context.read<NoteDatabase>().updateNote(
                          note.id,
                          textController.text,
                        );
                      } else {
                        context.read<NoteDatabase>().createNote(
                          textController.text,
                        );
                      }
                      textController.clear();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryClr.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      note != null ? "Update Note" : "Add Note",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  void openNoteDetailScreen(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.white),
      backgroundColor: MyColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBottomSheet(),
        backgroundColor: MyColors.bluishClr,
        child: const Icon(Icons.add, color: MyColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Notes",
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: MyColors.primaryClr,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return Dismissible(
                    key: Key(note.text),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => deleteNote(note.id),
                    direction: DismissDirection.endToStart,
                    child: GestureDetector(
                      onTap: () => openNoteDetailScreen(note),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MyColors.bluishClr,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  note.text,
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    () => openNoteBottomSheet(note: note),
                                icon: const Icon(
                                  Icons.edit,
                                  color: MyColors.white,
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
            ),
          ],
        ),
      ),
    );
  }
}

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _textController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.note.text);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveNote() {
    if (_textController.text.isNotEmpty) {
      context.read<NoteDatabase>().updateNote(
        widget.note.id,
        _textController.text,
      );
      _toggleEditMode();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        title: Text(
          _isEditing ? "Edit Note" : "Note Details",
          style: TextStyle(color: MyColors.black),
        ),
        iconTheme: IconThemeData(color: MyColors.black),
        actions: [
          IconButton(
            onPressed: _isEditing ? _saveNote : _toggleEditMode,
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: MyColors.black,
            ),
          ),
        ],
      ),
      backgroundColor: MyColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isEditing
                ? TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "Enter Note",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: null,
                  autofocus: true,
                )
                : SingleChildScrollView(
                  child: Text(
                    widget.note.text,
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
      ),
    );
  }
}
