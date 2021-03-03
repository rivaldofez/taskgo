import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskgo/add_task.dart';
import 'package:taskgo/main.dart';

class MyTask extends StatefulWidget {
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  MyTask({this.user, this.googleSignIn});

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  void _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250,
        child: Column(
          children: [
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Sign Out??", style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
                  },
                  child: Column(
                    children: [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16),
                      ),
                      Text("Yes"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.close),
                      Padding(
                        padding: EdgeInsets.all(16),
                      ),
                      Text("Cancel"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddTask(
                    email: widget.user.email,
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
        child: ButtonBar(
          children: [],
        ),
      ),
      body: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            image: DecorationImage(
                image: new AssetImage("images/patterns.png"),
                fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.user.photoUrl),
                            fit: BoxFit.cover)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            widget.user.displayName,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _signOut();
                    },
                  )
                ],
              ),
            ),
            Text(
              "My Task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontFamily: "Roboto"),
            )
          ],
        ),
      ),
    );
  }
}
