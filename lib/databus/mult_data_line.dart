import 'package:flutter_go/databus/data_line.dart';

mixin MultDataLine {
  final Map<String, SingleDataLine> dataBus = Map();

  SingleDataLine<T> getLine<T>(String key) {
    if (!dataBus.containsKey(key)) {
      SingleDataLine<T> dataLine = new SingleDataLine<T>();
      dataBus[key] = dataLine;
    }
    return dataBus[key];
  }

  void dispose() {
    dataBus.values.forEach((f) => f.dispose());
    dataBus.clear();
  }
}
