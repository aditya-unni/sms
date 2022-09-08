//@dart=2.9
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final isMe;
  final String text;
  final String user;
  final String time;

  const CustomChatBubble({Key key, this.isMe, this.text, this.user, this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Bubble(
            margin: BubbleEdges.only(top: 10),
            nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
            child: RichText(
              text: TextSpan(children: [
                if (!isMe)
                  TextSpan(
                      text: "$user \n",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                TextSpan(
                    text: "$text \n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                    text: "$time",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 10)),
              ]),
            ),
            color: isMe ? Colors.blue[200] : Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
