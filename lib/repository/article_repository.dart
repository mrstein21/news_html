import 'package:news_app/model/news.dart';
import 'package:news_app/repository/helper/api_provider.dart';

class ArticleRepository{
 ApiProvider _apiProvider=new ApiProvider();

 Future<List<News>>getArticle(int page)async{
  var response=await _apiProvider.get("/articles?page="+page.toString());
  return listNewsFromJson(response);
 }

 Future<News>getArticleDetail(String slug)async{
  var response=await _apiProvider.get("/articles/slug/"+slug);
  return News.fromJson(response["data"]);
 }

}