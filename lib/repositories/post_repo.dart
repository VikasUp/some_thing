import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:some_thing/model/post.dart';

class PostsRepo {
  static Future<List<Post>> fetchPosts() async {
    var client = http.Client();
    List<Post> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Post post = Post.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/photos'),
          body: {});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
