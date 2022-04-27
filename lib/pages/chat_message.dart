import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data['userPhotoUrl']),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data['imgUrl'] != null
                    ? Image.network(data['imgUrl'])
                    : Text(
                        data['text'],
                        style: const TextStyle(fontSize: 16),
                      ),
                // Text(
                //   data['senderName'],
                //   style: const TextStyle(
                //     fontSize: 13,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
