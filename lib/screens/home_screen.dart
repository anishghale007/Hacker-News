import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news/provider/comment_provider.dart';
import 'package:hacker_news/provider/story_provider.dart';
import 'package:hacker_news/screens/story_screen.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Hacker News')),
        backgroundColor: Colors.red,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final stories = ref.watch(storyProvider);
          return ListView.builder(
            itemCount: stories.length,
              itemBuilder: (context, index) {
                final data = stories[index];
                return InkWell(
                  onTap: () async {
                    ref.refresh(commentProvider);
                    ref.read(commentProvider.notifier).getComments(comments: data.kids);
                    Get.to(() => StoryScreen(
                        story: data), transition: Transition.leftToRight);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: ListTile(
                        title: Text(data.title!, style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text('by ${data.by!}'),
                        trailing: Column(
                            children: [
                              Icon(Icons.comment),
                              Text(data.kids?.length == null ? '0' : data.kids!.length.toString())
                            ],
                           ),
                      ),
                    ),
                  ),
                );
              }
          );
        }
      ),
    );
  }
}
