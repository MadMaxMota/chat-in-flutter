import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);
  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;
  final ImagePicker picker = ImagePicker();
  File imgFile;
  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  Future getImage(bool isCamera) async {
    var pickedFile = await picker.getImage(
        source: (isCamera == true) ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imgFile = File(pickedFile.path);
      } else {
        print("No image selected.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {
              showOptions(context);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Câmera",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 20),
                      ),
                      onPressed: () {
                        getImage(true);
                        if (imgFile == null) return;
                        widget.sendMessage(imgFile: imgFile);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Galeria",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 20),
                      ),
                      onPressed: () {
                        getImage(false);
                        if (imgFile == null) return;
                        widget.sendMessage(imgFile: imgFile);
                      },
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          );
        });
  }
}
