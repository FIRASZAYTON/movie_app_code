import 'package:clean_archeticture_movies/movies/presntaion/components/text_field_coustum.dart';
import 'package:clean_archeticture_movies/movies/presntaion/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/bloc_sign_in_out/sign_in_out_bloc.dart';
import 'movies_screen.dart';

class SigInScreen extends StatelessWidget {
  static String id = "sigInScreen";
  bool isLoading = false;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInOutBloc, SignInOutState>(
      listener: (context, state) {
        if (state is SignInloading) {
          isLoading = true;
        } else if (state is SignInSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainMoviesScreen.id, (Route<dynamic> route) => false);
          isLoading = false;
          clear();
        } else if (state is SignInFailure) {
          scaffoldMessenger(context, state.erorrMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: Colors.white70,
          ),
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade800.withOpacity(0.3),
                      Colors.black26,
                      Colors.black38,
                      Colors.black54,
                      Colors.grey.shade800.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.clamp),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 150, right: 20, left: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/Film rolls-bro.png",
                          width: 250,
                          height: 250,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        resubleTextField(
                            textInputType: TextInputType.emailAddress,
                            onchanged: (data) {},
                            text: "Enter Your Email",
                            isPassWordType: false,
                            controller: emailEditingController,
                            iconData: Icons.mail),
                        SizedBox(
                          height: 15,
                        ),
                        resubleTextField(
                          textInputType: TextInputType.visiblePassword,
                          onchanged: (data) {},
                          isPassWordType: true,
                          text: "Enter Your Password",
                          iconData: Icons.lock_outline,
                          controller: passwordEditingController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90)),
                          child: ElevatedButton(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey;
                                  } else {
                                    return Color.fromARGB(255, 48, 45, 45);
                                  }
                                }),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<SignInOutBloc>(context).add(
                                      SignInEvent(
                                          email: emailEditingController.text,
                                          password:
                                              passwordEditingController.text));
                                }
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have acconts ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: (() {
                                Navigator.pushNamed(context, SignUpScreen.id);
                              }),
                              child: Text(
                                "Sing Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void scaffoldMessenger(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void clear() {
    emailEditingController.clear();
    passwordEditingController.clear();
  }
}
