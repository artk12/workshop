
import 'package:flutter/foundation.dart';

const String MONITOR = "MONITORING";
const String DASHBOARD = "DASHBOARD";
const String NOTIFICATION = "NOTIFICATION";
const String ASSIGN = "ASSIGN";
const String TASKS = "TASKS";
const String LOG = "LOG";


class PublishManagerPageController extends ChangeNotifier{

  String page = DASHBOARD;
  int pageView = 0;

  void changePage(String page){
    this.page = page;
    notifyListeners();
  }

}