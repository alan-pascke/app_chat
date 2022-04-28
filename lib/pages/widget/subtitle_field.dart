import 'package:app_chat/pages/chat_screen.dart';
import 'package:flutter/material.dart';

class SubTitleField extends StatefulWidget {
  const SubTitleField({Key? key, this.sendImage, this.sendSubtitle})
      : super(key: key);
  //

  final Function()? sendImage;
  final Function({String text})? sendSubtitle;

  @override
  State<SubTitleField> createState() => _SubTitleFieldState();
}

class _SubTitleFieldState extends State<SubTitleField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Adicionar Legenda',
                hintStyle: TextStyle(color: Colors.white),
              ),
              onChanged: (text) {
                widget.sendSubtitle!(text: text);
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
            ),
            onPressed: () {
              if (_controller.text.isEmpty) {
                widget.sendImage!();
              } else {
                widget.sendImage!();
                widget.sendSubtitle!(text: _controller.text);
              }
              _controller.clear();
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
