import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/App%20Cubit/cubit.dart';
import 'package:newsapp/App%20Cubit/states.dart';
import 'package:newsapp/LayOut/LayOut_Cubit/cubit.dart';

import './Network/dio_helper.dart';
import './Network/shared_pref.dart';
import './observer.dart';
import './LayOut/layout_screen.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp({this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeLightTheme(fromShared: isDark)),
        BlocProvider(create: (context) => NewsCubit()..getNews()),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title:'Akhbarak',
            home: NewsScreen(),
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25
                ),
                bodyText2: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                caption: TextStyle(
                  fontSize: 15,
                ),
              ),
              scaffoldBackgroundColor: Colors.grey[300],
              iconTheme: const IconThemeData(
                  color: Colors.black
              ),

            ),
            darkTheme: ThemeData(
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25
                  ),
                  bodyText2: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  caption: TextStyle(
                    fontSize: 15,
                    color: Colors.black38
                  ),
                ),
                cardColor: Colors.grey[200],
                scaffoldBackgroundColor: Colors.black54,
              iconTheme: const IconThemeData(
                color: Colors.white
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}