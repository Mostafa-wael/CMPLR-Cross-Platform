import 'package:cmplr/utilities/custom_widgets/custom_underline.dart';
import 'package:cmplr/utilities/custom_widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The screen that shows when you choose to sign up with email
/// then go to your profile.
class EmailPasswordNameAfterSignup extends StatelessWidget {
  EmailPasswordNameAfterSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                // (Tarek) TODO: call the signup manager to check
                // the email, password, and username
              },
              child: const Text('Done'),
            )
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'What should we call you?',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You\'ll need a name to make your own posts,'
                    ' customize your blog, and message people.',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  const TextField(
                      // (Tarek) TODO: add a controller for this
                      // in the signup manager
                      controller: null,
                      decoration: InputDecoration(hintText: 'email')),
                  SizedBox(height: 8),
                  const TextField(
                    // (Tarek) TODO: add a controller for this
                    // in the signup manager
                    controller: null,
                    decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: Icon(Icons.remove_red_eye)),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  SizedBox(height: 8),
                  const TextField(
                      // (Tarek) TODO: add a controller for this
                      // in the signup manager
                      controller: null,
                      decoration: InputDecoration(hintText: 'name')),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    child: CustomUnderline(
                      text: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.blue[600]),
                      ),
                      underlineDistance: 1,
                      underlineWidth: 1,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Popup(
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 16, bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Hold on! Are you sure you have another'
                                      ' account? It would stink to lose'
                                      ' everything you just followed.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: const Text(
                                              'Nevermind',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            onTap: () {
                                              // (Tarek) TODO:
                                              // Close this elevated button/window
                                            },
                                          ),
                                          const SizedBox(width: 16),
                                          GestureDetector(
                                              child: Text(
                                                'I\'m sure',
                                                style: TextStyle(
                                                    color: Colors.blue[400]),
                                              ),
                                              onTap: () {
                                                // (Tarek) TODO:
                                                // Go to login page
                                              })
                                        ])
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.grey[900] ?? Colors.grey,
                              maxHeight: 120,
                            );
                          });
                    },
                  ),
                  GestureDetector(
                    child: CustomUnderline(
                      text: Text(
                        'Privacy dashboard',
                        style: TextStyle(fontSize: 20, color: Colors.blue[600]),
                      ),
                    ),
                    onTap: () {
                      // (Tarek) TODO:
                      // Show privacy policy
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: false);
  }
}
