import 'package:anytixapp/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    SignInSignUpResponse response = await AuthServices.signUp(
                        "anytix@admin.com",
                        "123321",
                        "Anytix",
                        ["Action", "Horror", "Music", "Drama"],
                        "Indonesian");

                    if (response.user == null) {
                      print(response.message);
                    } else {
                      print(response.user.toString());
                    }
                  }),
              ElevatedButton(
                  onPressed: () async {
                    SignInSignUpResponse response = await AuthServices.signIn(
                        "anytix@admin.com", "123321");

                    if (response.user == null) {
                      print(response.message);
                    } else {
                      print(response.user.toString());
                    }
                  },
                  child: Text("Sign In")),
              ElevatedButton(
                  onPressed: () async {
                    await AuthServices.signOut();
                  },
                  child: Text("Sign Out"))
            ],
          ),
        ),
      ),
    );
  }
}
