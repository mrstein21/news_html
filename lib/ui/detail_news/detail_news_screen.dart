import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:news_app/mixins/mixins.dart';
import 'package:news_app/mixins/server.dart';
import 'package:news_app/ui/detail_news/detail_news_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailNewsScreen extends StatelessWidget {
  DetailNewsController controller=Get.find<DetailNewsController>();
  String slug=Get.arguments["slug"];
  @override
  Widget build(BuildContext context) {
    controller.getArticle(slug);
    return Scaffold(
      body: GetBuilder<DetailNewsController>(
        init: DetailNewsController(),
        builder: (DetailNewsController controllerX){
          if(controller.isLoading==true){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return _buildUI();
          }
        },
      ),
    );
  }

  Widget _buildUI(){
    return NestedScrollView(
      headerSliverBuilder: (context,scroller){
        return <Widget>[
          SliverAppBar(
            leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              InkWell(
                child: Icon(Icons.share),
              ),
              SizedBox(width: 5,),
            ],
            titleSpacing: 0,
            title: Text(
              "",
              style: TextStyle(fontFamily: "Roboto"),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            expandedHeight: 240.0,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildCover(controller.news.image),
            ),
          )
        ];
      },
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            _buildInfo(controller.news.title,controller.news.created_at),
            SizedBox(height: 10,),
            _buildRenderHtml(controller.news.content),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title,String date){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold,
            fontSize: 16
        ),),
        SizedBox(height: 4,),
        Text(
          Mixins().changeDate(date),
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 4,),
      ],
    );
  }


  Widget _buildRenderHtml(String content){
    return HtmlWidget(
      content,
      customWidgetBuilder: (element){
        if(element.localName=="img" && element.attributes.containsKey("src")){
          return InkWell(
            //child: Image.network(element.attributes["src"]),
            child: CachedNetworkImage(
              imageUrl: element.attributes["src"],
              placeholder:(_,url)=> Center(child: CircularProgressIndicator(),),
            ),
            onTap: (){
              Get.toNamed("/full_image",arguments: {
                "url": element.attributes["src"]
              });
            },
          );
          print("source element "+element.attributes["src"]);
        }else if(element.localName=="iframe" && element.attributes["src"].contains("youtube")){
          String url=element.attributes["src"];
          YoutubePlayerController _controller= YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(url),
              flags: YoutubePlayerFlags(
                autoPlay: false,
              )
          );
          return YoutubePlayer(
            controller: _controller,
            bottomActions: [
              const SizedBox(width: 14.0),
              CurrentPosition(),
              const SizedBox(width: 8.0),
              ProgressBar(
                isExpanded: true,
              ),
              RemainingDuration(),
              InkWell(
                onTap: (){
                  _controller.pause();
                  Get.toNamed("/full_youtube",arguments: {
                    "url": element.attributes["src"],
                    "controller": _controller
                  });
                },
                child: Icon(Icons.fullscreen,color: Colors.white,size: 20,),
              ),

            ],
          );
        }
      },
      onTapUrl: (String url){
        controller.launchURL(url);
        print("click url "+url);
        ///  launchURL(url, context);
      },
      textStyle: TextStyle(fontFamily: 'Poppins'),
      webViewJs: true,
      webView: true,
      unsupportedWebViewWorkaroundForIssue37: false,
    );
  }

  Widget _buildCover(String image) {
    return CachedNetworkImage(
        width: double.infinity,
        height: 200,
        fit: BoxFit.fill,
        imageUrl: Server.url_image+image,
        placeholder: (_,url){
          return Center(child: CircularProgressIndicator(),);
        },
    );
  }


}
