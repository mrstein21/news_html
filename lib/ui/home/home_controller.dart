import 'package:get/get.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/article_repository.dart';

class HomeController extends GetxController{
  List<News>list=new List<News>();
  int page=1;
  bool isLoading;
  bool isNoMoreLoad;

  void loadArticle(){
    list=[];
    isLoading=true;
    isNoMoreLoad=false;
    page=1;
    update();
    ArticleRepository().getArticle(page).then((value){
      isLoading=false;
      list=value;
      update();
    });
  }

  void loadMoreArticle(){
    page=page+1;
    update();
    ArticleRepository().getArticle(page).then((value){
      list=[...list,...value];
      if(value.isEmpty){
        isNoMoreLoad=true;
      }
      update();
    }).catchError((err)=>print(err));
  }


}