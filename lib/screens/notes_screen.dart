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
                notes.add(
                  Note(
                    id: DateTime.now().toIso8601String(), // for unique id
                    title: titleTxtCtrl.text,
                    description: descTxtCtrl.text
                  ),
                );
                setState(() {}); // to reflect in output also
                // to clear the inputs after adding into list
                titleTxtCtrl.clear();
                descTxtCtrl.clear();
              } else {}
            },
            child: Text('Add'),
          ),

          // display list
          Expanded(
            child: ListView.builder(
              itemCount: notes
                  .length, // if we don't provide then, infinite scrolling will be there
              itemBuilder: (context, index) => ListTile(
                title: Text('${notes[index].title}'),
                subtitle: Text('${notes[index].description}'),
                trailing: IconButton(
                    onPressed: () {
                      // delete the note

                    }, 
                    icon: Icon(Icons.delete)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
