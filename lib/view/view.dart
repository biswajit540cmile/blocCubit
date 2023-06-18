import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cube_controller/cube_state.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollController = ScrollController();
  late PostsCubit _postsCubit;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _postsCubit = PostsCubit();
    _postsCubit.fetchPosts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _postsCubit.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _postsCubit.fetchPosts(page: _currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        bloc: _postsCubit,
        builder: (context, state) {
          if (state is PostsInitialState || state is PostsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoadedState) {
            final posts = state.posts;
            return ListView.builder(
              controller: _scrollController,
              itemCount: posts.length + 1, // +1 for loading indicator
              itemBuilder: (context, index) {
                if (index < posts.length) {
                 final post = posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text('ID: ${post.id}'),
                  );
                } else if (index == posts.length) {
                  return state.isData ? const Center(child: CircularProgressIndicator()): Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("No Data Avaliable")),
                  );
                }
                return null;
              },
            );
          } else if (state is PostsErrorState) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
