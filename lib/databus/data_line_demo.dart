import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mult_data_line.dart';

//DataLine的使用说明
//详情查看 http://wiki.lianjia.com/pages/viewpage.action?pageId=648387159
class DataLineDemo extends StatelessWidget with MultDataLine {
  String KEY1 = 'first';
  String KEY2 = 'second';


  int key1 = 0;
  int key2 = 999999;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getLine(KEY1).setData(key1);
    getLine(KEY2).setData(key2);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dataline'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return ListView(children: <Widget>[
      GestureDetector(
        child: Container(
          width: 150,
          height: 60,
          child: Center(
              child: Text(
            'key1的触发者',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
          decoration: BoxDecoration(color: Colors.grey),
        ),
        onTap: () {
          getLine<int>(KEY1).setData(key1++);
        },
      ),
      getLine<int>(KEY1).addObserver((context, data) {
        return Text(
          'key1当前的数据为 $data',
          style: TextStyle(
              fontSize: 19, color: Colors.green, fontWeight: FontWeight.w600),
        );
      }),
      getLine<int>(KEY1).addObserver(
        (context, data) {
          return Text(
            'key1当前的数据为 $data',
            style: TextStyle(
                fontSize: 19, color: Colors.blue, fontWeight: FontWeight.w600),
          );
        },
      ),
      GestureDetector(
        child: Container(
          width: 150,
          height: 60,
          child: Center(
              child: Text(
            'key2的触发者',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
          decoration: BoxDecoration(color: Colors.grey),
        ),
        onTap: () {
          getLine(KEY2).setData(key2++);
        },
      ),
      getLine(KEY2).addObserver((context, data) {
        return Text(
          'key2当前的数据为 $data',
          style: TextStyle(
              fontSize: 19, color: Colors.pink, fontWeight: FontWeight.w600),
        );
      }),
      getLine(KEY2).addObserver(
        (context, data) {
          return Text(
            'key2当前的数据为 $data',
            style: TextStyle(
                fontSize: 19, color: Colors.red, fontWeight: FontWeight.w600),
          );
        },
      ),
    ]);
  }
}
