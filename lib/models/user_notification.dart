class UserNotification {
  final String imageUrl; // Make this non-nullable
  final String content; // Make this non-nullable
  final String time; // Make this non-nullable

  UserNotification({
    required this.imageUrl, // Use required to ensure a value is provided
    required this.content, // Use required to ensure a value is provided
    required this.time, // Use required to ensure a value is provided
  });
}

List<UserNotification> notifications = [
  UserNotification(
      imageUrl: 'assets/goalcast.png',
      content: 'Goalcast posted a new video',
      time: '3 hours ago'),
  UserNotification(
      imageUrl: 'assets/playstation.jpg',
      content: 'Playstation posted a new video',
      time: '8 hours ago'),
  UserNotification(
      imageUrl: 'assets/xbox.jpeg',
      content: 'Xbox posted a new video',
      time: '9 hours ago'),
  UserNotification(
      imageUrl: 'assets/reddit.png',
      content: 'Reddit posted a new video',
      time: '22 hours ago'),
  UserNotification(
      imageUrl: 'assets/linkedIn.jpg',
      content: 'Linkedin posted a new video',
      time: '1 day ago'),
  UserNotification(
      imageUrl: 'assets/goalcast.png',
      content: 'Goalcast posted a new video',
      time: '4 days ago'),
  UserNotification(
      imageUrl: 'assets/reddit.png',
      content: 'Reddit posted a new video',
      time: '6 days ago'),
  UserNotification(
      imageUrl: 'assets/xbox.jpeg',
      content: 'Xbox posted a new video',
      time: '1 week ago'),
  UserNotification(
      imageUrl: 'assets/linkedIn.jpg',
      content: 'Linkedin posted a new video',
      time: '3 weeks ago'),
  UserNotification(
      imageUrl: 'assets/playstation.jpg',
      content: 'Playstation posted a new video',
      time: '1 month ago'),
];
