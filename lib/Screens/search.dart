import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/LayOut/LayOut_Cubit/states.dart';
import 'package:newsapp/Screens/web_view_screen.dart';
import '../LayOut/LayOut_Cubit/cubit.dart';

class SearchScreen extends StatelessWidget {

 var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        final cubitListener = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text('Search' , style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                  ),
                  child: TextFormField(
                    controller: searchController ,
                    keyboardType: TextInputType.text,
                    onChanged: (word){
                      return cubitListener.search(word);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      label:  Text('Search'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: searchController.text.isNotEmpty ? ListView.builder(
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
                                        image: NetworkImage('${cubitListener.searchList[index]['urlToImage']}'),
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
                                        child: Text(cubitListener.searchList[index]['title'] ,
                                          style: Theme.of(context).textTheme.bodyText2,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(DateTime.parse(cubitListener.searchList[index]['publishedAt']).toLocal().toString() , style: Theme.of(context).textTheme.caption,),
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewScreen(url: cubitListener.searchList[index]['url'], authorName: cubitListener.searchList[index]['author'],)));
                    },
                    splashColor: Colors.purpleAccent,
                  ),
                  itemCount: cubitListener.searchList.length,) : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
