import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  final String email;
  AddTask({this.email});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dueDate = new DateTime.now();
  String _dateText = "";
  String newTask = "";
  String note = "";

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _addData() {
    Firestore.instance.runTransaction((transaction) async {
      CollectionReference reference = Firestore.instance.collection("task");
      await reference.add({
        "email": widget.email,
        "title": newTask,
        "duedate": _dateText,
        "note": note
      });
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/patterns.png"),
                    fit: BoxFit.cover),
                color: Colors.blueGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "My Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2,
                      fontFamily: "Roboto"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("Add Task",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      )),
                ),
                Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  newTask = value;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.dashboard),
                  hintText: "New Task",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range),
                ),
                Expanded(
                  child: Text(
                    "Due Date",
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                ),
                FlatButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text(
                    _dateText,
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  note = value;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: "Note",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 40,
                  ),
                  onPressed: () {
                    _addData();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
