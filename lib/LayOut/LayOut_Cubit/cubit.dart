import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Network/dio_helper.dart';
import '/LayOut/LayOut_Cubit/states.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get (context){
    return BlocProvider.of(context);
  }

  List<dynamic> newsList = [];

  void getNews(){
    newsList = [];
    emit(NewsLoadingState());

    DioHelper.getData(url: 'v2/top-headlines' , query: {
      'country' : 'eg',
      'category' : 'business',
      'apiKey' : 'd745b378a0f44906b347600d289edfe2'
    }).then((response){
      newsList = response.data['articles'];
      emit(NewsSuccessState());
    });
  }

  List<dynamic> searchList = [];

  void search(String word){
    searchList = [];
    emit(NewsLoadingState());

    DioHelper.getData(
        url: 'v2/everything' ,
        query: {
          'q' : word,
      'apiKey' : 'd745b378a0f44906b347600d289edfe2',
    }).then((response){
      searchList = response.data['articles'];
      emit(NewsSearchSuccessState());
    });
  }

}