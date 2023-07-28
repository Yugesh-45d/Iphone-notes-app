// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_final_fields, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/datas/note_data.dart';
import 'package:notes/models/note_model.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  NoteModel note;
  bool isNewNote;

  NotePage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    loadExistingNote();
    super.initState();
  }

  //load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
    });
  }

  //add new note
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //get text from editor
    String text = _controller.document.toPlainText();

    //add the new note
    Provider.of<NoteData>(context, listen: false).addNewNote(
      NoteModel(id: id, text: text),
    );
  }

  //update existing note
  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  // void deleteNote() {
  //   Provider.of<NoteData>(context, listen: false).deleteNote(widget.note);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              //if it's a new note
              if (widget.isNewNote && !_controller.document.isEmpty()) {
                addNewNote();
              } else {
                updateNote();
              }
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Column(
          children: [
            quill.QuillToolbar.basic(
              controller: _controller,
              showDividers: false,
              showFontFamily: false,
              showFontSize: false,
              showBoldButton: false,
              showItalicButton: false,
              showSmallButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showInlineCode: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showAlignmentButtons: false,
              showLeftAlignment: false,
              showCenterAlignment: false,
              showRightAlignment: false,
              showJustifyAlignment: false,
              showHeaderStyle: false,
              showListNumbers: false,
              showListBullets: false,
              showListCheck: false,
              showCodeBlock: false,
              showQuote: false,
              showIndent: false,
              showLink: false,
              showUndo: false,
              showRedo: false,
              showDirection: false,
              showSearchButton: false,
              showSubscript: false,
              showSuperscript: false,
            ),
            Expanded(
              child: quill.QuillEditor(
                controller: _controller,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                scrollable: true,
                padding: const EdgeInsets.all(10),
                autoFocus: false,
                readOnly: false,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
