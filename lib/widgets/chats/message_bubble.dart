import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImage;
  final Key key;

  MessageBubble(this.message, this.isMe, this.username, this.userImage,
      {this.key});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final GlobalKey _keyRed = GlobalKey();
  Offset positionRed;
  Size sizeRed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSizes();
      print(sizeRed);
      print(positionRed);
    });
  }

  getSizes() {
    RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    if (_keyRed.currentContext == null) print("no");
    setState(() {
      sizeRed = renderBoxRed.size;
      positionRed = renderBoxRed.localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          key: widget.key,
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              key: _keyRed,
              decoration: BoxDecoration(
                color: widget.isMe
                    ? Theme.of(context).primaryColor.withOpacity(0.7)
                    : Theme.of(context).accentColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      !widget.isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      widget.isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.username,
                    style: TextStyle(
                      color: widget.isMe ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.message,
                    style: TextStyle(
                      color: widget.isMe ? Colors.black : Colors.white,
                    ),
                    textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!widget.isMe)
          Positioned(
            left: positionRed == null ? 0 : (sizeRed.width - 25),
            bottom: sizeRed == null ? 0 : (sizeRed.height - 40),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.userImage),
              radius: 20,
            ),
          ),
        if (widget.isMe)
          Positioned(
            right: positionRed == null ? 0 : (sizeRed.width - 25),
            bottom: sizeRed == null ? 0 : (sizeRed.height - 40),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.userImage),
              radius: 20,
            ),
          ),
      ],
      overflow: Overflow.visible,
    );
  }
}
