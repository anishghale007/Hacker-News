import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/models/comments.dart';



final commentProvider = StateNotifierProvider<CommentProvider, List<Comment>>((ref) => CommentProvider());
List<Comment> commentList = [];

class CommentProvider extends StateNotifier<List<Comment>>{
  CommentProvider() : super([]);

  Future<void> getComments({List? comments}) async{
    final dio = Dio();
    try{
      if(comments != null) {
        for(var i = 0; i < comments.length; i++){
          int id = await comments[i];
          final news = await dio.get("https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty");
          Map<String, dynamic> map = news.data;
          final data = await Comment.fromJson(map);
          commentList.add(data);
        }
        state = commentList;
      }
    } on DioError catch(err) {
      print(err);
    }

  }



}