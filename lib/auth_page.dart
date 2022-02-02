import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

String  _pass = '123456';
String _name = 'admin';



class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {


    TextEditingController nameContoller = TextEditingController();
    TextEditingController passContoller = TextEditingController();


    const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(36)),
      borderSide: BorderSide(color: Color(0xFFECEFF1), width: 2),
    );

    _inputDecoration(String _text) {
      return InputDecoration(
        filled: true,
        fillColor: Color(0xFFECEFF1),
        hintText: _text,
        contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        hintStyle: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.4), ),
        enabledBorder: borderStyle,
        focusedBorder: borderStyle,
      );
    }

    return Scaffold(
              resizeToAvoidBottomInset : false,
              body:
              Container(
                padding: EdgeInsets.fromLTRB(0, 160, 0, 0),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                        width: 244,
                        child: Text('Введите данные для авторизации:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,
                              color: Colors.blueGrey),)
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 244,
                      height: 34,
                      child: TextFormField(
                        controller: nameContoller,
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.4)),
                        decoration: _inputDecoration('Логин'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 244,
                      height: 34,
                      child: TextFormField(
                        controller: passContoller,
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.4)),
                        obscureText: true,
                        decoration: _inputDecoration('Пароль',),
                      ),
                    ),
                    SizedBox(height: 28,),
                    SizedBox(height: 42, width: 154,
                        child: ElevatedButton(
                          onPressed: () {
                          if((nameContoller.text == _name)&&(passContoller.text == _pass)==true){
                            Navigator.pushNamed(context, '/listusers');}
                          else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  
//                                  title: Text('Title'),
                                  content: Text('Введены некорректные данные', style: TextStyle(color: Colors.blueGrey),),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(62, 132, 161, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(22.0)
                                        ),
                                      ),
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                           },
                          child: Text('Войти'),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(62, 132, 161, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 28,),
                  ],
                ),
              )
    );
  }
}





