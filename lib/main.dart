import 'package:anytixapp/services/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Sign Up"),
                onPressed: () async {
                  SignInSignUpResult result = await AuthServices.signUp(
                      "anytix@admin.com",
                      "141414",
                      "Anytix",
                      ["Action", "Music", "Drama", "Romance"],
                      "English");
                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
              ),
              RaisedButton(
                child: Text("Sign In"),
                onPressed: () async {
                  SignInSignUpResult result =
                      await AuthServices.signIn("anytix@admin.com", "141414");
                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
              ),
              RaisedButton(
                child: Text("Sign Out"),
                onPressed: () async {
                  AuthServices.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
