import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news/models/stories.dart';
import 'package:hacker_news/provider/comment_provider.dart';
import 'package:hacker_news/provider/story_provider.dart';
import 'package:hacker_news/screens/home_screen.dart';

class StoryScreen extends StatelessWidget {
  late Story story;
  StoryScreen({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer(
          builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                Get.to(() => HomePage());
                ref.refresh(commentProvider);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.red,),
            );
          }
        ),
        title: Center(
          child: Text(
            'Comments (${story.kids!.length.toString()}) ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(story.title!, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  Text('By ${story.by!}', style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .80,
            child: Consumer(
              builder: (context, ref, child) {
                final comments = ref.watch(commentProvider);
                return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final data = comments[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                                  child: Icon(Icons.person)),
                              title: Text(data.by == null ? 'Unknown' : data.by!, style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(data.text == null ? 'No comment' : data.text!.toString()),
                              trailing: Text(data.parent == null ? 'No parent' : data.parent!.toString()),
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
