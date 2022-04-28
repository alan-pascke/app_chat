import 'package:app_chat/pages/widget/open_camera.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextComposer extends StatefulWidget {
  TextComposer({Key? key, this.sendMessage}) : super(key: key);
  //
  Function({String text})? sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar uma mensagem',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage!(text: text);
                _controller.clear();
                setState(() {
                  _isComposing = false;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenCamera(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.photo_camera),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
                    widget.sendMessage!(text: _controller.text);
                    _controller.clear();
                    setState(() {
                      _isComposing = false;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.send,
            ),
          )
        ],
      ),
    );
  }
}
