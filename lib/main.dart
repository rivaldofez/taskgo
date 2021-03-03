import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskgo/my_task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Go",
      theme: new ThemeData(primarySwatch: Colors.purple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    final acc = await googleSignIn.signIn();
    final auth = await acc.authentication;

    final credential = GoogleAuthProvider.getCredential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    final result = await firebaseAuth.signInWithCredential(credential);
    FirebaseUser firebaseUser = result.user;

    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new MyTask(
              user: firebaseUser,
              googleSignIn: googleSignIn,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgrounds.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/android.png",
              width: 250,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: InkWell(
                  onTap: () {
                    _signIn();
                  },
                  child: Image.asset("images/signin.png")),
            ),
          ],
        ),
      ),
    );
  }
}
