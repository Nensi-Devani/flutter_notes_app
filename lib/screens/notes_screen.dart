// stateful widget to get the updates

import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleTxtCtrl = TextEditingController();
  TextEditingController descTxtCtrl = TextEditingController();
  List<Note> notes = []; // creating list
  String selId = "";
  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Scaffold(
      appBar: AppBar(title: Text('Notes App')),
      body: Column(
        children: [
          TextField(
            controller: titleTxtCtrl,
            decoration: InputDecoration(
              hintText: 'Enter title',
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: descTxtCtrl,
            decoration: InputDecoration(
              hintText: 'Enter description',
              labelText: 'Description',
            ),
          ),

          // button
          ElevatedButton(
            onPressed: () {
              // add note logic
              if (titleTxtCtrl.text.isNotEmpty && descTxtCtrl.text.isNotEmpty) {
                if (selId == "") {
                  // add new note
                  notes.add(
                    Note(
                      id: DateTime.now().toIso8601String(), // for unique id
                      title: titleTxtCtrl.text,
                      description: descTxtCtrl.text,
                    ),
                  );
                } else {
                  // update the note
                  int index = notes.indexWhere((note) => note.id == selId);
                  if (index > -1) {
                    notes[index] = Note(
                      id: selId,
                      title: titleTxtCtrl.text,
                      description: descTxtCtrl.text,
                    );
                  }
                  selId = ""; // remove Update btn after update and visible Add btn
                }
                setState(() {}); // to reflect in output also
                // to clear the inputs after adding into list
                titleTxtCtrl.clear();
                descTxtCtrl.clear();
              } else {}
            },
            child: Text(selId == "" ? 'Add' : 'Update'),
          ),

          // display list
          Expanded(
            child: ListView.builder(
              itemCount: notes
                  .length, // if we don't provide then, infinite scrolling will be there
              itemBuilder: (context, index) => ListTile(
                title: Text('${notes[index].title}'),
                subtitle: Text('${notes[index].description}'),

                trailing: SizedBox(
                  width:
                      MediaQuery.of(context).size.width *
                      0.20, // 20 % width to make responsive
                  child: Row(
                    // delete / edit icons
                    children: [
                      IconButton(
                        // edit the note
                        onPressed: () {
                          // set the value in inputs to edit
                          titleTxtCtrl.text = notes[index].title;
                          descTxtCtrl.text = notes[index].description;
                          selId = notes[index].id;
                          setState(() {});
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        // delete the note
                        onPressed: () {
                          notes.removeAt(index);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
