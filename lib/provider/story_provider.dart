import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/models/stories.dart';


final storyProvider = StateNotifierProvider<StoryProvider, List<Story>>((ref) => StoryProvider());

List<Story> storyList = [];
late List idList = [];

class StoryProvider extends StateNotifier<List<Story>> {
  StoryProvider() : super([]){
    getTopStories();
  }


  Future<void> getTopStories() async {
    final dio = Dio();
    try{
      final response = await dio.get("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty");
      print(response);
      idList = response.data;
      print(idList.length);
      for(int i = 0; i < 20; i++){
        int id = idList[i];
        final news = await dio.get("https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty");
        Map<String, dynamic> map = news.data;
        final data = Story.fromJson(map);
        storyList.add(data);
      }
      state = storyList;
    } on DioError catch(err) {
      print(err);
    }
  }



}