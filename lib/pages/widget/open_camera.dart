// ignore_for_file: avoid_print, unrelated_type_equality_checks, must_be_immutable

import 'dart:io';

import 'package:app_chat/pages/widget/subtitle_field.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class OpenCamera extends StatefulWidget {
  const OpenCamera({Key? key}) : super(key: key);

  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  List<CameraDescription> _cameras = [];
  CameraLensDirection direction = CameraLensDirection.back;
  CameraController? _controller;
  XFile? imagem;
  File? img;
  String? urlImage;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadcameras();
  }

  void _loadcameras() async {
    try {
      _cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  _startCamera() {
    if (_cameras.isEmpty) {
      print('Camera não foi encontrada');
    } else {
      _previewCamera(_cameras[direction.index]);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = cameraController;

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  _arquivoWidget() {
    return ListView(
      children: [
        SizedBox(
          height: 700,
          width: MediaQuery.of(context).size.width,
          child: imagem == null
              ? _cameraPreviewWidget()
              : Image.file(File(imagem!.path), fit: BoxFit.contain),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.8),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: SubTitleField(sendImage: _sendImageOrMessage),
            ),
          ],
        ),
      ],
    );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('Widget para a camera não está disponivel');
    } else {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: SizedBox(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CameraPreview(_controller!),
              // cameraOverlay(padding: 50, aspectRatio: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _botaoLigaFlash(),
                  _botaoCapturaFoto(),
                  _botaoTrocaCamera(),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  _botaoCapturaFoto() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.black.withOpacity(.5),
          child: IconButton(
            icon: const Icon(Icons.camera_sharp),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              takePicture();
            },
          ),
        ),
      ),
    );
  }

  _botaoTrocaCamera() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: IconButton(
            icon: const Icon(Icons.cameraswitch_outlined),
            color: Colors.white,
            iconSize: 30,
            onPressed: () => trocaCamera()),
      ),
    );
  }

  _botaoLigaFlash() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: IconButton(
          icon: const Icon(Icons.flash_off),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {},
        ),
      ),
    );
  }

  takePicture() async {
    final CameraController? cameraController = _controller;
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) {
          setState(() {
            imagem = file;
            img = File(imagem!.path);
          });
        }
      } on CameraException catch (e) {
        print(e.description);
      }
    }
  }

  trocaCamera() {
    if (direction == CameraLensDirection.front) {
      direction = CameraLensDirection.back;
    } else if (direction == CameraLensDirection.back) {
      direction = CameraLensDirection.front;
    }
    _startCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: _arquivoWidget(),
        ),
      ),
      // floatingActionButton: (imagem != null)
      //     ? SizedBox(
      //         height: 65,
      //         width: 75,
      //         child: SubTitleField(
      //           sendImage: _sendImage,
      //         ))
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _sendImageOrMessage({String? text}) async {
    try {
      if (img != null) {
        firebase_storage.TaskSnapshot task = await firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(img!);

        urlImage = await task.ref.getDownloadURL();

        Map<String, dynamic> data = {
          'imgUrl': urlImage,
        };

        if (text != null) data['text'] = text;

        FirebaseFirestore.instance.collection('messages').add(data);
      }
    } on firebase_core.FirebaseException catch (e) {
      print(e.message);
    }
  }
}
