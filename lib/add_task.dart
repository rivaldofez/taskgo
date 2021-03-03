import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
          TextField(
            decoration: InputDecoration(
                icon: Icon(Icons.dashboard),
                hintText: "New Task",
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
