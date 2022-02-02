import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itog_project/auth_page.dart';
import 'package:itog_project/info_todo.dart';
import 'package:itog_project/menu_drawer.dart';
import 'package:itog_project/user_details.dart';


int idUser=0;

Future<List<User>> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    return parseUser(response.body);
  } else {
    throw Exception('Failed to load UserList');
  }
}

List<User> parseUser(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class User{
  int id;
  String name;
  String email;
  String company;

  User({required this.id, required this.name, required this.email, required this.company});


 factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      company: json['company']['name'] as String,
    );
  }
}

late Future<List<User>> futureUser;


class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  @override

  void initState(){
    super.initState();
    futureUser = fetchUser();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(62, 132, 161, 1),
              title: Text('Пользователи'),
              actions: [
              IconButton(onPressed: (){
                setState(() {
                  futureUser = fetchUser();
                });
              }, icon: Icon(Icons.cached_sharp),),
            ],),
            drawer: menuDrawer(context),
            body: SizedBox(
              width: double.infinity,
              child: fBuilderUserList(),
            ),

      ),
      routes: {
        '/authpage': (context) => AuthPage(),
        '/listusers': (context) => ListUsers(),
        '/todo': (context) => ToDo(),
        '/userdetails': (context) => UserDetails(),
      },
    );
  }
}

FutureBuilder fBuilderUserList() {

  FutureBuilder _fBuilderUserList = FutureBuilder<List<User>>(
    future: futureUser,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
// Text(snapshot.data!.first.name);
        return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                    subtitle: Row(
                        children: [
                          SizedBox(width: 30, height: 30, child: Image(image: AssetImage('assets/foto/noname_user.png'))),
                          SizedBox(width: 20,),
                          SizedBox(
                            width: 250,
                            child: Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                                  Text('E-mail: '+snapshot.data![index].email, style: TextStyle(fontSize: 13, color: Colors.blueGrey),),
                                  Text('Компания: '+snapshot.data![index].company, style: TextStyle(fontSize: 13, color: Colors.blueGrey),),
                                ]
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: IconButton(
                              onPressed: (){
                                idUser = snapshot.data![index].id;
                                Navigator.pushNamed(context, '/userdetails');
                              },
                                icon: Icon(Icons.info_outline, color: Colors.blueGrey,)),
                          ),

                        ]
                    ),
                    onTap: () {
                      idUser = snapshot.data![index].id;
                      Navigator.pushNamed(context, '/todo');
                    },
                  )
              );
            }
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      return const CircularProgressIndicator();
    },
  );
  return _fBuilderUserList;
}

