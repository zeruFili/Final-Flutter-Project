class Post {
  String? id; // Unique identifier for the post (optional)
  String userId; // The ID of the user who created the post
  String content; // Content of the post
  String imageUrl; // URL for the post's image
  String visibility; // Visibility of the post (e.g., public, private)
  List<Map<String, dynamic>> likes; // List of likes
  List<Map<String, dynamic>> comments; // List of comments
  DateTime createdAt; // Creation timestamp
  DateTime updatedAt; // Last update timestamp

  Post({
    this.id, // ID can be set later
    required this.userId,
    required this.content,
    required this.imageUrl,
    required this.visibility,
    this.likes = const [],
    this.comments = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Post from a map
  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      id: data['_id'] ?? data['id'], // Adjust based on your backend response
      userId: data['userId'],
      content: data['content'],
      imageUrl: data['imageUrl'],
      visibility: data['visibility'],
      likes: List<Map<String, dynamic>>.from(data['likes'] ?? []),
      comments: List<Map<String, dynamic>>.from(data['comments'] ?? []),
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['updatedAt']) ?? DateTime.now(),
    );
  }

  // Method to convert a Post to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'visibility': visibility,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
