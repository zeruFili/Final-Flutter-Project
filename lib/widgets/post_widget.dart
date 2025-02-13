import 'package:flutter/material.dart';
import 'package:facebook_ui_flutter/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostWidget extends StatelessWidget {
  final Post? post;

  PostWidget({this.post});

  @override
  Widget build(BuildContext context) {
    // Fallback values in case post is null
    final String profileImageUrl =
        post?.profileImageUrl ?? 'assets/default_profile.png';
    final String username = post?.username ?? 'Unknown User';
    final String time = post?.time ?? 'Just Now';
    final String content = post?.content ?? 'No content';
    final String likes = post?.likes ?? '0'; // Adjusted to string
    final String comments = post?.comments ?? '0'; // Adjusted to string
    final String shares = post?.shares ?? '0';

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(profileImageUrl),
                radius: 20.0,
              ),
              SizedBox(width: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0)),
                  SizedBox(height: 5.0),
                  Text(time),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            width: 820.0,
            height: 220.0, // Add height for better visibility
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://sp.yimg.com/ib/th?id=OIP.y8KJR6C240KyDdrtHKG1JwHaK3&pid=Api&w=148&h=148&c=7&dpr=2&rs=1'), // Replace with your network image URL
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 20.0),
          Text(content, style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.thumbsUp,
                      size: 15.0, color: Colors.blue),
                  Text(' $likes'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('$comments comments  •  '),
                  Text('$shares shares'),
                ],
              ),
            ],
          ),
          Divider(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Like', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Comment', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.share, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Share', style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
