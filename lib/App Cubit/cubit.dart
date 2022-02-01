import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Network/shared_pref.dart';


import '/App%20Cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get( BuildContext context){
   return BlocProvider.of(context);
  }


  bool isDark = false;

  void changeLightTheme({bool fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeAppState());
    }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark' , value: isDark).then((value){
        emit(ChangeAppState());
      });

    }
  }
}