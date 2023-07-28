// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_final_fields, must_be_immutable, prefer_const_literals_to_create_immutables, deprecated_member_use
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/datas/note_data.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/utilities/colors.dart';
import 'package:notes/widgets/info_modal_widget.dart';
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
    final doc = quill.Document()..insert(0, widget.note.text);
    setState(() {
      _controller = quill.QuillController(
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

  void clearDocument() {
    // Create an empty Delta, which represents an empty document.
    final quill.Delta delta = quill.Delta()..insert("\n");

    // Create a new QuillController with the empty Delta.
    final newController = quill.QuillController(
      document: quill.Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );

    // Set the new controller as the active controller.
    setState(() {
      _controller = newController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (widget.isNewNote && !_controller.document.isEmpty()) {
            addNewNote();
          } else {
            updateNote();
          }
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.isNewNote &&
                            !_controller.document.isEmpty()) {
                          addNewNote();
                        } else {
                          updateNote();
                        }
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.back,
                            color: secondaryColor,
                            size: 28,
                          ),
                          Text(
                            "All Notes",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.share,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                           onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return InfoModalWidget();
                    },
                  );
                },
                          child: SvgPicture.asset(
                            "assets/pending.svg",
                            height: 28,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                if (value == 1) {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoActionSheet(
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text(
                              'Choose from library',
                              style: TextStyle(
                                color: thirdColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text(
                              'Take a photo',
                              style: TextStyle(
                                color: thirdColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text(
                              'Voice Memos',
                              style: TextStyle(
                                color: thirdColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: thirdColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  );
                } else if (value == 3) {
                  clearDocument();
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: quill.QuillToolbar.basic(
                    toolbarIconSize: 24,
                    iconTheme: quill.QuillIconTheme(
                      borderRadius: 24,
                      iconUnselectedColor: secondaryColor,
                      iconSelectedColor: secondaryColor,
                    ),
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
                    showListCheck: true,
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
                  label: '',
                ),
                // BottomNavigationBarItem(
                //   icon: Image.asset(
                //     "assets/checklist.png",
                //     height: 32,
                //   ),
                //   label: '',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: secondaryColor,
                    size: 28,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: quill.QuillToolbar.basic(
                    toolbarIconSize: 28,
                    iconTheme: quill.QuillIconTheme(
                      borderRadius: 24,
                      iconUnselectedColor: secondaryColor,
                      iconSelectedColor: secondaryColor,
                    ),
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
                    showColorButton: true,
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
                  label: '',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.brush,
                //     color: secondaryColor,
                //     size: 28,
                //   ),
                //   label: '',
                // ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/edit.svg",
                    height: 24,
                    color: secondaryColor,
                  ),
                  label: '',
                ),
              ]),
        ),
      ),
    );
  }
}
