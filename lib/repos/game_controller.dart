import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GameController extends ChangeNotifier{
  SharedPreferences? _sharedPreferences;
  int _currentLevel = 0;
  int get currentLevel => _currentLevel;

  void saveCurrentLevel(level)async{
     _sharedPreferences = await SharedPreferences.getInstance();
     _sharedPreferences!.setInt("currentLevel", level);
     print(level);
     _currentLevel = level;
     notifyListeners();


  }

  Future<int> getCurrentLevel()async{
    _sharedPreferences = await SharedPreferences.getInstance();
     int? i =  _sharedPreferences!.getInt("currentLevel");
     int  j = i != null?1:0;
     
     return j;


  }

}