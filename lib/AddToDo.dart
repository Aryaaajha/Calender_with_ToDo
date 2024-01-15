import 'package:flutter/material.dart';

class AnotherScreen extends StatefulWidget {
  final Function(String, String) onSubmit;

  AnotherScreen({required this.onSubmit});

  @override
  _AnotherScreenState createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  TextEditingController _todoController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 20),
            Text("  Add ToDo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            SizedBox(height: 10),
            TextField(
              controller: _todoController,
              decoration: InputDecoration(
                labelText: "What needs to be done?",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0),),
              ),
            ),
            SizedBox(height: 40),
            Text("  Add Time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            SizedBox(height: 10),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: "What time it has to be done?",
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(40.0), ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Round corners
              ),) ,
              onPressed: () {
                widget.onSubmit(_todoController.text, _timeController.text);
                _todoController.clear();
                _timeController.clear();
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
