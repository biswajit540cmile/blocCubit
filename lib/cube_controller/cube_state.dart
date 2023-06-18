import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../model/post.dart';


class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  List<Post> p =[];

  Future<void> fetchPosts({int page = 1}) async {
    try {
      var apiUrl = 'https://jsonplaceholder.typicode.com/posts?_page=$page';

      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var posts = Post.fromJsonList(json.decode(response.body));
        p.addAll(posts);
        bool? isData;
        posts.isEmpty ? isData = false : isData = true;
        emit(PostsLoadedState(posts: p, isData:isData ));
      } else {
        emit(PostsErrorState(message: 'Failed to fetch posts'));
      }
    } catch (e) {
      emit(PostsErrorState(message: 'An error occurred'));
    }
  }
}

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<Post> posts;
  final bool isData;
  PostsLoadedState({required this.posts, required this.isData});
}

class PostsErrorState extends PostsState {
  final String message;

  PostsErrorState({required this.message});
}
