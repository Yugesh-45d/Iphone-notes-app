// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:notes/models/note_model.dart';

class NoteData extends ChangeNotifier {
  List<NoteModel> allNotes = [
    NoteModel(id: 0, text: 'First Note'),
  ];
  //Yo list le NoteModel type ko data matra linxa

  List<NoteModel> getAllNotes() {
    return allNotes;
  }
  //yo function le vaeko jati sabai notes haru return gardinxa (NoteModel type ko List ko form ma)

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
  //Yesle purano note ko text ma aru text add grxa

  void deleteNote(NoteModel note) {
    allNotes.remove(note);
    notifyListeners();
  }
  //Yesle existing note lai delete gardinxa
}
