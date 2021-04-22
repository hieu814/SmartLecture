import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  int _counter = 0;
  List<int> _data = [1, 2, 3, 4, 5];
  getCounter() => _counter;

  setCounter(int counter) => _counter = counter;

  void incrementCounter() {
    int x = _counter;
    _data.add(x);
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}

class MyStream {
  List<Offset> _data;
  int counter = 0;
  StreamController counterController = StreamController<
      List<Offset>>.broadcast(); //= new StreamController<int>();
  Stream get counterStream => counterController.stream.asBroadcastStream();
  //g//et controllerOut => counterController.stream.asBroadcastStream();
  get controllerIn => counterController.sink;
  MyStream() {
    //counterController = new StreamController<List<int>>();
    //counterController.stream.listen((event) => _data.add(event));
    _data = [Offset(1.0, 2.9)];
  }
  void addx(Offset t) {
    counter += 1;
    _data.add(t);
    controllerIn.add(_data);
  }

  void sua(int inx, Offset t) {
    _data[inx] = t;
    controllerIn.add(_data);
  }

  void decre() {
    counter += 1;
    _data.removeLast();
    controllerIn.add(_data);
  }

  void dispose() {
    counterController.close();
  }
}

// Random Colour generator

