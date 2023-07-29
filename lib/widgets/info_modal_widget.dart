// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/utilities/colors.dart';

class InfoModalWidget extends StatefulWidget {
  const InfoModalWidget({super.key});

  @override
  State<InfoModalWidget> createState() => _InfoModalWidgetState();
}

class _InfoModalWidgetState extends State<InfoModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 376,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  height: 72,
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.pin_fill,
                        color: secondaryColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Pin",
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  height: 72,
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  height: 72,
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.lock_fill,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lock",
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(
                title: Text(
                  "Search in note",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  CupertinoIcons.search,
                  size: 28,
                ),
              ),
              CupertinoListTile.notched(
                title: Text(
                  "Word note count",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "0",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoListTile.notched(
                title: Text(
                  "Text note size",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "100%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoListTile.notched(
                title: Text(
                  "Note font",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "Use default",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoListTile.notched(
                title: Text(
                  "Alignment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "Left",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
