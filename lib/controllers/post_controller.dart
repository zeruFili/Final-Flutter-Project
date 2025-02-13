import 'package:get/get.dart';
import '../apis/post_apis.dart';
import '../models/posts.dart'; // Adjust the path as necessary

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs; // Observable list of posts
  final PostApis postApi;

  PostController(this.postApi);

  @override
  void onInit() {
    super.onInit();
    fetchAllPublicPosts(); // Fetch posts when the controller initializes
  }

  // Fetch all public posts
  Future<void> fetchAllPublicPosts() async {
    try {
      final response = await postApi.getAllPublicPosts();
      posts.clear();
      response.data.forEach((element) {
        posts.add(Post.fromMap(element)); // Assuming Post.fromMap exists
      });
    } catch (error) {
      Get.snackbar("Error", "Failed to retrieve posts: $error");
    }
  }

  // Create a new post
  Future<void> createPost(
      String userId, String content, String imageUrl, String visibility) async {
    try {
      await postApi.createPost(userId, content, imageUrl, visibility);
      fetchAllPublicPosts(); // Refresh the list after creating a post
    } catch (error) {
      Get.snackbar("Error", "Failed to create post: $error");
    }
  }

  // Update an existing post
  Future<void> updatePost(String postId, String userId, String content,
      String imageUrl, String visibility) async {
    try {
      await postApi.updatePost(postId, userId, content, imageUrl, visibility);
      fetchAllPublicPosts(); // Refresh the list after updating
    } catch (error) {
      Get.snackbar("Error", "Failed to update post: $error");
    }
  }

  // Delete a post
  Future<void> deletePost(String postId, String userId) async {
    try {
      await postApi.deletePost(postId, userId);
      posts.removeWhere((post) => post.id == postId); // Remove from local list
    } catch (error) {
      Get.snackbar("Error", "Failed to delete post: $error");
    }
  }

  // Like a post
  Future<void> likePost(String postId, String userId) async {
    try {
      await postApi.likePost(postId, userId);
      // Optionally refresh the post list or specific post
    } catch (error) {
      Get.snackbar("Error", "Failed to like post: $error");
    }
  }

  // Add a comment to a post
  Future<void> addComment(String postId, String userId, String content) async {
    try {
      await postApi.addComment(postId, userId, content);
      // Optionally refresh the post list or specific post
    } catch (error) {
      Get.snackbar("Error", "Failed to add comment: $error");
    }
  }
}
