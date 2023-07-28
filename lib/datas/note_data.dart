import 'package:flutter/cupertino.dart';
import 'package:notes/models/note_model.dart';

class NoteData extends ChangeNotifier {
  List<NoteModel> allNotes = [
    NoteModel(id: 0, text: 'First Note'),
  ];

  List<NoteModel> getAllNotes() {
    return allNotes;
  }

  void addNewNote(NoteModel note) {
    allNotes.add(note);
    notifyListeners();
  }

  void updateNote(NoteModel note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNote(NoteModel note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
