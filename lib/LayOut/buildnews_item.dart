import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Screens/custom_route.dart';
import 'package:newsapp/Screens/web_view_screen.dart';

import '/LayOut/LayOut_Cubit/cubit.dart';
import '/LayOut/LayOut_Cubit/states.dart';

class NewsMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        final cubit = NewsCubit.get(context);
        return cubit.newsList.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context , index) =>  InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 8,
                  color: Theme.of(context).cardColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage('${cubit.newsList[index]['urlToImage']}'),
                                fit: BoxFit.cover,
                            )
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(cubit.newsList[index]['title'] ,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(DateTime.parse(cubit.newsList[index]['publishedAt']).toLocal().toString() , style: Theme.of(context).textTheme.caption,),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewScreen(url: cubit.newsList[index]['url'], authorName: cubit.newsList[index]['author'],)));
            },
            splashColor: Colors.purpleAccent,
          ),
          itemCount: cubit.newsList.length,) : const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
