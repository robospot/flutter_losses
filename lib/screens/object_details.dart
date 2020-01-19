import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ObjectDetails extends StatefulWidget {
  final dynamic object;
  ObjectDetails({Key key, this.object}) : super(key: key);

  @override
  _ObjectDetailsState createState() => _ObjectDetailsState();
}

class _ObjectDetailsState extends State<ObjectDetails> {
  @override
  Widget build(BuildContext context) {
    final message =
        // ignore: lines_longer_than_80_chars
        'kjkkjkjkjk';
    QrPainter qrcode = QrPainter(
      data: message,
      version: QrVersions.auto,
      color: Color(0xff1a5441),
      emptyColor: Color(0xffeafcf6),
      // size: 320.0,)
    );

    // final qrFutureBuilder = FutureBuilder(
    //   future: _loadOverlayImage(),
    //   builder: (ctx, snapshot) {
    //     final size = 280.0;
    //     if (!snapshot.hasData) {
    //       return Container(width: size, height: size);
    //     }
    //     return CustomPaint(
    //       size: Size.square(size),
    //       painter: QrPainter(
    //         data: message,
    //         version: QrVersions.auto,
    //         color: Color(0xff1a5441),
    //         emptyColor: Color(0xffeafcf6),
    //         // size: 320.0,
    //         // embeddedImage: snapshot.data,
    //         // embeddedImageStyle: QrEmbeddedImageStyle(
    //         //   size: Size.square(200),
    //         // ),
    //       ),
    //     );
    //   },
    // );

    return Scaffold(
        appBar: AppBar(
          title: Text("Моя вещь"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(widget.object['description']),
              ),
              Container(
                width: 100,
                child:
                    //qrFutureBuilder,
                    CustomPaint(size: Size.square(100), painter: qrcode),
              ),
              RaisedButton(
                  child: Text("Share"), onPressed: () => shareObject(qrcode))
            ],
          ),
        ));
  }

  // Future<ui.Image> _loadOverlayImage() async {
  //   final completer = Completer<ui.Image>();
  //   final byteData = await rootBundle.load('assets/logo_yakka.png');
  //   ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
  //   return completer.future;
  // }
}

shareObject(QrPainter qrcode) async {
  final ByteData bytes = await qrcode.toImageData(200);
  await Share.file(
    'esys image',
    'esys.png',
    bytes.buffer.asUint8List(),
    'image/png',
    text: 'My optional text.',
  );
}
