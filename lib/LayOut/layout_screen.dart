import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Screens/custom_route.dart';


import '../App%20Cubit/states.dart';
import '../Screens/search.dart';
import '../App%20Cubit/cubit.dart';
import '/LayOut/buildnews_item.dart';



class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          body:SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      Text('News' , style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const Spacer(),
                      IconButton(onPressed: (){
                        Navigator.of(context).push(CustomRoute(builder: (context) => SearchScreen()));
                      }
                      ,icon: const Icon(Icons.search),),
                      IconButton(onPressed: (){
                        AppCubit.get(context).changeLightTheme();
                      },
                        icon: const Icon(Icons.brightness_4_rounded ),),
                    ],
                  ),
                ),
                NewsMainScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
