import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Key key;
  final String userName;
  final String message;
  final bool belongsToMe;
  final String userImage;

  MessageCard(this.message, this.belongsToMe, this.userName, this.userImage,
      {this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: _size.width * 0.4,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: belongsToMe ? Colors.grey[200] : Colors.green[700],
                borderRadius: belongsToMe
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(5),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
              ),
              child: Column(
                crossAxisAlignment: belongsToMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: belongsToMe ? Colors.black : Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: belongsToMe ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: belongsToMe ? _size.width * 0.35 : null,
          left: belongsToMe ? null : _size.width * 0.35,
          child: CircleAvatar(
            backgroundImage: NetworkImage(this.userImage),
          ),
        ),
      ],
    );
  }
}
