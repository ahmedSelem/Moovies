import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Screens/home_screen.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = '/auth';
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  GlobalKey<FormState> form;
  FocusNode passwordNode, confirmPasswordNode;
  bool loginMode, loadingBtnSign;
  String email, password;
  GlobalKey<ScaffoldState> scaffoldKey;
  @override
  void initState() {
    super.initState();
    form = GlobalKey<FormState>();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    loginMode = true;
    scaffoldKey = GlobalKey<ScaffoldState>();
    loadingBtnSign = false;
  }

  void validateToLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        loadingBtnSign = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .signIn(email, password);
      if (error != null) {
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              error,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.red[200],
          ),
        );
         setState(() {
          loadingBtnSign = false;
        });
      } else {
        // print('error please fixed it');

        Navigator.of(context).pushReplacementNamed(HomeScreen.rounteName);
       
      }
    }
  }

  void validateToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        loadingBtnSign = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .signUp(email, password);
      if (error != null) {
         scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              error,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.red[200],
          ),
        );
        setState(() {
          loadingBtnSign = false;
        });
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.rounteName);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  alignment: Alignment.center,
                  child: Text(
                    'Roovies',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                ),
                Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          setState(() {
                            email = value;
                          });
                          if (EmailValidator.validate(value)) {
                            return null;
                          }
                          return 'Invalid email address';
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          passwordNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'example@abc.com',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          setState(() {
                            password = value;
                          });
                          if (value.length >= 6) {
                            return null;
                          }
                          return 'Password must contain 6 characters at least';
                        },
                        obscureText: true,
                        onFieldSubmitted: (value) {
                          if (!loginMode) {
                            confirmPasswordNode.requestFocus();
                          }
                        },
                        focusNode: passwordNode,
                        textInputAction: (loginMode)
                            ? TextInputAction.done
                            : TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: '••••••••',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (!loginMode) ...[
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == password) {
                              return null;
                            }
                            return 'Passwords must match';
                          },
                          obscureText: true,
                          focusNode: confirmPasswordNode,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white30,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: '••••••••',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: (loadingBtnSign)
                      ? Center(child: CircularProgressIndicator())
                      : FlatButton(
                          color: Colors.white,
                          child: Text(
                            loginMode ? 'Login' : 'Register',
                          ),
                          onPressed: () {
                            if (loginMode) {
                              validateToLogin();
                            } else {
                              validateToRegister();
                            }
                          },
                        ),
                ),
                (loginMode)
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            loginMode = !loginMode;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Register Now!',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            loginMode = !loginMode;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Login Now!',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
