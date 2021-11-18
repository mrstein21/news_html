import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/ui/home/home_controller.dart';
import 'package:news_app/ui/widgets/row_news.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller=Get.find<HomeController>();
  ScrollController scrollController =ScrollController();

  Future<void>refreshData()async {
    controller.loadArticle();
    return null;
  }


  void onScroll(){
    double maxScroll=scrollController.position.maxScrollExtent;
    double currentScroller=scrollController.position.pixels;
    if(maxScroll==currentScroller){
      if(controller.isNoMoreLoad==false){
        controller.loadMoreArticle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.loadArticle();
    scrollController.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: Text("SteinNews"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (HomeController homeController){
               if(controller.isLoading==true){
                 return _buildLoading();
               }else{
                 return _buildList();
               }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(){
    return ListView.builder(
        itemCount: controller.isNoMoreLoad==true?controller.list.length:
        controller.list.length+1,
        controller:scrollController,
        itemBuilder: (ctx,index){
          if(index<controller.list.length) {
            return RowNews(news: controller.list[index],);
          }else{
            return _buildLoading();
          }
        }
    );
  }


}


