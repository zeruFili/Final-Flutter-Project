import 'package:flutter/material.dart';
import 'package:facebook_ui_flutter/models/user_notification.dart';

class NotificationWidget extends StatelessWidget {
  final UserNotification? notification;

  NotificationWidget({this.notification});

  @override
  Widget build(BuildContext context) {
    // Fallback values in case notification or its properties are null
    final String imageUrl =
        notification?.imageUrl ?? 'assets/default_image.png'; // Default image
    final String content =
        notification?.content ?? 'No content available'; // Default content
    final String time = notification?.time ?? 'Just now'; // Default time

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 35.0,
              ),
              SizedBox(width: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(content,
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold)),
                  Text(time,
                      style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.more_horiz),
              Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
