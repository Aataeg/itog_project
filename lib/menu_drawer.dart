import 'package:flutter/material.dart';

const List<String> _drawerList = <String>['Пользователи'];
const List<String> _drawerListDivider = <String>['Выйти'];

Widget? menuDrawer(context) =>
    Container(
      width: 250,
      child: Drawer(
        child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(62, 132, 161, 1),
                  ),
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.zero,
                    child: Image(image: AssetImage('assets/foto/icon-to-do.png'),),
                  )
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    //                  color: Colors.blue,
                    height: 50,
                    child: ListTile(
                      title: Text(_drawerList[index], style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(62, 132, 161, 1),
                      ),),
                      onTap: () {
                        switch (index) {
                          case 0:
                            {
//                              _indexBottomBar = 0;
                              Navigator.pushNamed(context, '/listusers');
                              break;
                            }
                        }
                      },
                    ),
                  );
                },
              ),
              Divider(),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _drawerListDivider.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    height: 50,
                    child: ListTile(
                      title: Text(
                        _drawerListDivider[index], style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(62, 132, 161, 1),
                        //fontStyle: FontStyle.normal,
                      ),),
                      onTap: () {
                        switch (index) {
                          case 0:
                            {
//                              _indexBottomBar = 2;
                              Navigator.pushNamed(context, '/authpage');
                              break;
                            }
                        }
                      },
                    ),
                  );
                },
              ),

            ]
        ),
      ),
    );
