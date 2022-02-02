import 'package:flutter/material.dart';
import 'package:itog_project/list_users.dart';
import 'package:itog_project/userClass.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<UserInfo> fetchUserInfo() async {
  final responseInfo = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'+idUser.toString()));
  print('https://jsonplaceholder.typicode.com/users/'+idUser.toString());

  if (responseInfo.statusCode == 200) {
    return parseUserInfo(responseInfo.body);
//  return UserInfo.fromJson(jsonDecode(responseInfo.body));
  } else {
    throw Exception('Failed to load UserInfo');
  }
}

UserInfo parseUserInfo(String responseBodyInfo){
  final parsedInfo = json.decode(responseBodyInfo) as Map<String, dynamic>;

  return UserInfo.fromJson(jsonDecode(responseBodyInfo));
}

const List<BottomNavigationBarItem> _bottomBar = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    label: 'Call',
    icon: Icon(Icons.call, color: Color.fromRGBO(62, 132, 161, 1),),),
  BottomNavigationBarItem(
    icon: Icon(Icons.email_outlined, color: Color.fromRGBO(62, 132, 161, 1),),
    label: 'E-mail',), ];


class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late Future<UserInfo> futureUserInfo;

  @override

  void initState(){
    super.initState();
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
        Flexible(
          child: SizedBox(
//          width: 300,
            child: Text(strR, style: _textStyleR),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(62, 132, 161, 1),
        title: Text('Информация о пользователе', style: TextStyle(fontSize: 16),),
          actions: [
          IconButton(onPressed: (){
    setState(() {
    futureUserInfo = fetchUserInfo();
    });
    }, icon: Icon(Icons.cached_sharp),),
      ]),
      bottomNavigationBar: bottomNavBar(context),
      body: SingleChildScrollView(
        child: FutureBuilder<UserInfo>(
          future: futureUserInfo,
          builder: (contextInfo, snapshotInfo){
              if (snapshotInfo.hasData){
              return Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SizedBox(width: 300, child:  Image(image: AssetImage('assets/foto/noname_user.png'),),)),
                SizedBox(child: Divider(color: Color(0xFFC4C4C4), thickness: 1.00,),),
                Center(
                  child: Column(
                    textDirection: TextDirection.ltr,
 //                   crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _makeRow('ID пользователя: ', snapshotInfo.data!.id.toString()),
                      SizedBox(height: 5,),
                      _makeRow('Пользователь: ', snapshotInfo.data!.name),
                      SizedBox(height: 5,),
                      _makeRow('Имя пользователя: ', snapshotInfo.data!.username),
                      SizedBox(height: 5,),
                      _makeRow('Телефон: ', snapshotInfo.data!.phone),
                      SizedBox(height: 5,),
                      _makeRow('Адрес: ', snapshotInfo.data!.address),
                      SizedBox(height: 5,),
                      _makeRow('E-mail: ', snapshotInfo.data!.email),
                      SizedBox(height: 5,),
                      _makeRow('Web-сайт: ', snapshotInfo.data!.website),
                      SizedBox(height: 5,),
                      _makeRow('Компания:', snapshotInfo.data!.companyName),
                      SizedBox(height: 5,),
                      _makeRow('Вид деятельности: ', snapshotInfo.data!.companyCatchPhrase),
                      SizedBox(height: 5,),
                      _makeRow('Направление: ', snapshotInfo.data!.companyBs),
                    ],
                  ),
                ),
                SizedBox(child: Divider(color: Color(0xFFC4C4C4), thickness: 1.00,),),
                  ],
                  );
                  }
                  else if (snapshotInfo.hasError) {
                  return Text('Error: ${snapshotInfo.error}');
                  }
                  return const CircularProgressIndicator();
              },
        ),
      ),
    );
  }
}

Widget? bottomNavBar(context) => BottomNavigationBar(
  items: _bottomBar,
  currentIndex: 0,
  onTap: (int index) {switch (index) {
    case 0:
      {
        (){}; //Call
        break;
      }
    case 1:
      {
        (){}; //e-mail
        break;
      }

  }},
);
