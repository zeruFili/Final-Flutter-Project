import 'package:dio/dio.dart';
import '../models/posts.dart'; // Adjust the path as necessary
import 'base_api.dart';

class PostApis extends BaseUrl {
  // Inherit Dio from BaseUrl

  // Create a new post
  Future<void> createPost(
      String userId, String content, String imageUrl, String visibility) async {
    final newPost = {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'visibility': visibility,
    };

    try {
      final response = await dio.post('/posts', data: newPost);
      print('Post created successfully: ${response.data}');
    } catch (error) {
      print('Error creating post: $error');
      throw Exception('Error creating post: $error');
    }
  }

  // Update a post
  Future<Response> updatePost(String postId, String userId, String content,
      String imageUrl, String visibility) async {
    try {
      final post = await dio.get('/posts/$postId');
      if (post.data['userId'] != userId) {
        throw Exception('Forbidden');
      }

      final updatedPost = {
        'content': content ?? post.data['content'],
        'imageUrl': imageUrl ?? post.data['imageUrl'],
        'visibility': visibility ?? post.data['visibility'],
      };

      return await dio.put('/posts/$postId', data: updatedPost);
    } catch (error) {
      throw Exception('Error updating post: $error');
    }
  }

  // Delete a post
  Future<Response> deletePost(String postId, String userId) async {
    try {
      final post = await dio.get('/posts/$postId');
      if (post.data['userId'] != userId) {
        throw Exception('Forbidden');
      }

      return await dio.delete('/posts/$postId');
    } catch (error) {
      throw Exception('Error deleting post: $error');
    }
  }

  // Get a specific post by ID if it's public
  Future<Response> getPost(String postId) async {
    try {
      final post = await dio.get('/posts/$postId');
      if (post.data['visibility'] != 'public') {
        throw Exception('Forbidden: Post is not public');
      }
      return post;
    } catch (error) {
      throw Exception('Error retrieving post: $error');
    }
  }

  // Get all public posts
  Future<Response> getAllPublicPosts() async {
    try {
      return await dio.get('/posts/public');
    } catch (error) {
      throw Exception('Error retrieving posts: $error');
    }
  }

  // Like a post
  Future<Response> likePost(String postId, String userId) async {
    try {
      final post = await dio.get('/posts/$postId');
      final likes = post.data['likes'] ?? [];

      if (likes.any((like) => like['userId'] == userId)) {
        await dio.delete('/posts/$postId/like/$userId');
      } else {
        await dio.post('/posts/$postId/like', data: {'userId': userId});
      }

      return await dio.get('/posts/$postId'); // Return updated post
    } catch (error) {
      throw Exception('Error updating like status: $error');
    }
  }

  // Add a comment to a post
  Future<Response> addComment(
      String postId, String userId, String content) async {
    final comment = {
      'userId': userId,
      'content': content,
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      return await dio.post('/posts/$postId/comments', data: comment);
    } catch (error) {
      throw Exception('Error adding comment: $error');
    }
  }
}
