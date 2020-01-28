import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_losses/utils/constants.dart';
import 'package:flutter_losses/utils/firebase_db.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:typed_data';

class ItemDetailScreen extends StatefulWidget {
  final Item item;
  ItemDetailScreen({Key key, this.item}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  bool showEmail = true;
  bool showPhone = true;

  @override
  void initState() {
    super.initState();
    itemNameController.text = widget.item.itemName;
    itemDescriptionController.text = widget.item.itemDescription;
  }

  @override
  Widget build(BuildContext context) {
    final String link =
        // ignore: lines_longer_than_80_chars
        '${ConfigStorage.baseUrl}?q=${widget.item.itemId}';
    QrPainter qrcode = QrPainter(
      data: link,
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
          actions: <Widget>[
            IconButton(icon: Icon(Icons.mode_edit), onPressed: ()=> changeDetails(),)
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(16),
            child: Form(
              child: Center(
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: itemNameController,
                      decoration: new InputDecoration(labelText: 'Название'),
                    ),
                    TextFormField(
                      controller: itemDescriptionController,
                      decoration: new InputDecoration(labelText: 'Описание'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Показывать телефон"),
                        Switch(
                          value: widget.item.showPhone,
                          onChanged: (bool value) => showPhoneChanged(value),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Показывать email"),
                        Switch(
                          value: widget.item.showEmail,
                          onChanged: (bool value) => showEmailChanged(value),
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 24, bottom: 8),
                        width: 200,
                        child:
                            //qrFutureBuilder,
                            CustomPaint(
                                size: Size.square(200), painter: qrcode),
                      ),
                    ),
                    Center(child: Text(link)),
                    RaisedButton(
                        child: Text("Share"),
                        onPressed: () => shareObject(qrcode))
                  ],
                ),
              ),
            )));
  }

  // Future<ui.Image> _loadOverlayImage() async {
  //   final completer = Completer<ui.Image>();
  //   final byteData = await rootBundle.load('assets/logo_yakka.png');
  //   ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
  //   return completer.future;
  // }
  showEmailChanged(bool value) {
    FirebaseService db = FirebaseService();
    setState(() {
      widget.item.showEmail = value;

      db.updateItem(widget.item);
    });
  }

  showPhoneChanged(bool value) {
    FirebaseService db = FirebaseService();
    setState(() {
      widget.item.showPhone = value;
      db.updateItem(widget.item);
    });
  }
  changeDetails(){
    
  }
}

shareObject(QrPainter qrcode) async {
  final ByteData bytes = await qrcode.toImageData(200);
  await Share.file(
    'esys image',
    'esys.png',
    bytes.buffer.asUint8List(),
    'image/png',
    text: 'Персональный QR код',
  );
}
