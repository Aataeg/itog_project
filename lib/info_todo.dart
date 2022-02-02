import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itog_project/list_users.dart';
import 'package:itog_project/menu_drawer.dart';
import 'package:itog_project/userClass.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<UserToDo>> fetchUserToDo() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId='+idUser.toString()));

  if (response.statusCode == 200) {
    return parseUserToDo(response.body);
  } else {
    throw Exception('Failed to load UsersToDo');
  }
}

List<UserToDo> parseUserToDo(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserToDo>((json) => UserToDo.fromJson(json)).toList();
}

class UserToDo{
  int userId;
  int id;
  String title;
  bool completed;

  UserToDo({required this.userId,
            required this.id,
            required this.title,
            required this.completed});


  factory UserToDo.fromJson(Map<String, dynamic> json) {
    return UserToDo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}

Future<UserInfo> fetchUserInfo() async {
  final responseInfo = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'+idUser.toString()));

  if (responseInfo.statusCode == 200) {
    return parseUserInfo(responseInfo.body);
//  return UserInfo.fromJson(jsonDecode(responseInfo.body));
  } else {
    throw Exception('Failed to load UserInfo');
  }
}

UserInfo parseUserInfo(String responseBodyInfo){
  final parsedInfo = json.decode(responseBodyInfo) as Map<String, dynamic>;
//  final parsedInfo = json.decode(responseBodyInfo).cast<Map<String, dynamic>>();

  return UserInfo.fromJson(jsonDecode(responseBodyInfo));
//  return parsedInfo.map<UserInfo>((json)=> UserInfo.fromJson(json));
}

//userClass



class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  late Future<List<UserToDo>> futureUserToDo;
  late Future<UserInfo> futureUserInfo;

  @override

  void initState(){
    super.initState();
    futureUserToDo = fetchUserToDo();
    futureUserInfo = fetchUserInfo();
  }

  var _textStyleN = TextStyle(color: Colors.blueGrey);
  var _textStyleR = TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey);

  _makeRow(String strN, String strR){
    return Row(
      children: [
        SizedBox(
          child: Text(strN,style: _textStyleN,),
        ),
        SizedBox(
//          width: 300,
            child: Text(strR, style: _textStyleR),
          ),
      ],
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(62, 132, 161, 1),
        title: Text('Список задач'),
        actions: [
        IconButton(onPressed: (){
          setState(() {
            futureUserToDo = fetchUserToDo();
            futureUserInfo = fetchUserInfo();
          });
        }, icon: Icon(Icons.cached_sharp),),
      ],),
        drawer: menuDrawer(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  SizedBox(width: 100, height: 80, child:  Image(image: AssetImage('assets/foto/noname_user.png'),),),
                  Row(children: [
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, '/userdetails');
                    }, icon: Icon(Icons.info_outline, color: Colors.blueGrey,),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.call, color: Colors.blueGrey)),
                  ],),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                width: 200,
                child: FutureBuilder<UserInfo>(
                future: futureUserInfo,
                  builder: (contextInfo, snapshotInfo){
                  if (snapshotInfo.hasData){
                    return SizedBox(
                      child: Column(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _makeRow('Пользователь: ', snapshotInfo.data!.name),
                          SizedBox(height: 5,),
                          _makeRow('Имя пользователя: ', snapshotInfo.data!.username),
                          SizedBox(height: 5,),
                          _makeRow('Компания: ', snapshotInfo.data!.companyName),
                          SizedBox(height: 5,),
                          _makeRow('Телефон: ', snapshotInfo.data!.phone),
                          SizedBox(height: 5,),
                          _makeRow('E-mail: ', snapshotInfo.data!.email),
                        ],
                      ),
                    );
                  }
                   else if (snapshotInfo.hasError) {
                      return Text('Error: ${snapshotInfo.error}');
                    }
                     return const CircularProgressIndicator();
                  },
            ),
              ),
            ]),

            FutureBuilder<List<UserToDo>>(
              future: futureUserToDo,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int  index) {
                            return Card(
                              color: _cardColor(snapshot.data![index].completed),
                                child: ListTile(
                                  subtitle: Row(
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Column(
                                              textDirection: TextDirection.ltr,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                Text(snapshot.data![index].title,
                                                  style: TextStyle(fontSize: 16),),
                                                ]
                                          ),
                                        ),
                                        SizedBox(
                                          child: Checkbox(
                                            activeColor: Colors.blueGrey,
                                            value: snapshot.data![index].completed,
                                            onChanged: (_val){},
                                          ),
                                        )]
                                  ),
                                )
                            );
                          }
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                   return const CircularProgressIndicator();
                   }
                  ),
          ],
        ),
    );
  }
}

Color _cardColor(bool completed) {
  if (completed == true){
    return Color.fromRGBO(146, 198, 142, 1);}
    else
      {
        return Color.fromRGBO(255, 187, 187, 1);
      }
}


void _launchURL() async {
  var email = 'test@example.com';
  var subject = Uri.encodeComponent('Hello');
  var body = Uri.encodeComponent('This is a test.');
  var url = 'mailto:$email?subject=$subject&body=$body';
  if (!await launch(url)) throw 'Could not launch';
}

Future<void> _makePhoneCall() async {
  // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
  // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
  // such as spaces in the input, which would cause `launch` to fail on some
  // platforms.
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: 'aa@bb.com',
  );
  await launch(launchUri.toString());
}
