import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/mixins/mixins.dart';
import 'package:news_app/mixins/server.dart';
import 'package:news_app/model/news.dart';

class RowNews extends StatelessWidget {
  News news;
  RowNews({
   this.news
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Get.toNamed("/articles",arguments: {
            "slug":news.slug
          });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
                fit: BoxFit.fill,
                height: 105,
                width: 100,
                imageUrl: Server.url_image+news.image,
                placeholder: (_,test){
                  return Center(child: CircularProgressIndicator(),);
                },
            ),
            SizedBox(width: 6,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    news.title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    Mixins().changeDate(news.created_at),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    news.short_description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontFamily: "Poppins",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
