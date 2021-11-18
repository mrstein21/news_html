import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app/ui/detail_news/detail_news_binding.dart';
import 'package:news_app/ui/detail_news/detail_news_screen.dart';
import 'package:news_app/ui/full_picture/full_picture_screen.dart';
import 'package:news_app/ui/full_youtube/full_youtube.dart';
import 'package:news_app/ui/home/home_binding.dart';
import 'package:news_app/ui/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/",
          page: ()=>HomeScreen(),
          binding: HomeBinding()
        ),
        GetPage(
            name: "/articles",
            page: ()=>DetailNewsScreen(),
            binding: DetailNewsBinding()
        ),
        GetPage(
            name: "/full_image",
            page: ()=>FullImagePage(),
        ),
        GetPage(
            name: "/full_youtube",
            page: ()=>FullYoutubePage()
        )
      ],
      initialRoute: "/",
    );
  }
}

