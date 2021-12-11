import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/article_repository.dart';

class DetailNewsController extends GetxController{
  bool isLoading=true;
  News news;
  void getArticle(String slug){
    ArticleRepository().getArticleDetail(slug).then((value){
      news=value;
      isLoading=false;
      update();
    });
  }

  void launchURL(String url) async {
    // try {
    //   await launch(
    //     url,
    //     customTabsOption: CustomTabsOption(
    //       enableDefaultShare: true,
    //       enableUrlBarHiding: true,
    //       showPageTitle: true,
    //       extraCustomTabs: const <String>[
    //         // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
    //         'org.mozilla.firefox',
    //         // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
    //         'com.microsoft.emmx',
    //       ],
    //     ),
    //   );
    // } catch (e) {
    //   // An exception is thrown if browser app is not installed on Android device.
    //   debugPrint(e.toString());
    // }
  }
}