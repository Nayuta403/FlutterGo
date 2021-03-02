import 'dart:async';

import 'package:flutter/material.dart';

class SingleDataLine<T> {
  StreamController<T> _stream;

  //拿到当前最新的数据
  T currentData;

  SingleDataLine([T initData]) {
    currentData = initData;
    _stream = StreamController.broadcast();
    _stream.add(initData);
  }

  get outer => _stream.stream;

  get inner => _stream.sink;

  void setData(T t) {
    if (t == currentData) return;
    print("发送了一次数据 $t");
    if (_stream.isClosed) return;
    currentData = t;
    inner.add(t);
  }

  Widget addObserver(
    Widget Function(BuildContext context, T data) observer,
  ) {
    return DataObserverWidget<T>(this, observer);
  }

  void dispose() {
    _stream.close();
  }
}

class DataObserverWidget<T> extends StatefulWidget {
  final SingleDataLine<T> _dataLine;
  final Widget Function(BuildContext ctx, T state) _builder;

  DataObserverWidget(this._dataLine, this._builder);

  @override
  State<StatefulWidget> createState() {
    return _DataObserverWidgetState<T>();
  }
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: widget._dataLine.outer,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot != null && snapshot.data != null) {
          print(
              " ${context.widget.toString()} 中的steam接收到了一次数据${snapshot.data}");
          return widget._builder(context, snapshot.data);
        } else {
          return Row();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._dataLine.dispose();
  }
}
