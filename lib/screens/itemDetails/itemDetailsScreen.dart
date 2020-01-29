import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/screens/itemDetails/bloc/itemdetails_bloc.dart';
import 'package:flutter_losses/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'widgets/itemOptions.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item item;
  ItemDetailsScreen({Key key, this.item}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  ItemdetailsBloc itemDetailsBloc;
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  Item itemDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemDetailsBloc = BlocProvider.of<ItemdetailsBloc>(context);
    itemDetailsBloc.add(GetItemDetails(item: widget.item));
  }

  @override
  Widget build(BuildContext context) {
    final String link =
        // ignore: lines_longer_than_80_chars
        '${ConfigStorage.baseUrl}?q=11';
    QrPainter qrcode = QrPainter(
      data: link,
      version: QrVersions.auto,
      color: Color(0xff1a5441),
      emptyColor: Color(0xffeafcf6),
      // size: 320.0,)
    );

    return BlocBuilder<ItemdetailsBloc, ItemdetailsState>(
        builder: (context, state) {
      if ((state is ItemDetailsInitial) || (state is ItemDetailsLoading)) {
        return CircularProgressIndicator();
      }
      if (state is ItemDetailsLoaded) {
        itemDetails = state.item;
        itemNameController.text = itemDetails.itemName;
        itemDescriptionController.text = itemDetails.itemDescription;

        return Scaffold(
            appBar: AppBar(
              title: Text("Вещь"),
              actions: <Widget>[
                IconButton(
                  icon: state.isEditing
                      ? Icon(Icons.save)
                      : Icon(Icons.mode_edit),
                  onPressed: () => changeItemDetails(state, widget.item),
                )
              ],
            ),
            body: Container(
                margin: EdgeInsets.all(16),
                child: Form(
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          enabled: state.isEditing ? true : false,
                          controller: itemNameController,
                          decoration:
                              new InputDecoration(labelText: 'Название'),
                          onChanged: (val) => itemDetails.itemName = val,
                        ),
                        TextFormField(
                          enabled: state.isEditing ? true : false,
                          controller: itemDescriptionController,
                          decoration:
                              new InputDecoration(labelText: 'Описание'),
                          onChanged: (val) => itemDetails.itemDescription = val,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Text("Показывать телефон"),
                        //     Switch(
                        //       value: itemDetails.showPhone,
                        //       onChanged: (bool value) =>
                        //           showPhoneChanged(value),
                        //     )
                        //   ],
                        // ),
                        ItemOptions(
                          title: "Email",
                          value: itemDetails.showEmail,
                          visibility: state.isEditing,
                          callback: (val) {
                            showEmailChanged(val);
                          },
                        ),
                        ItemOptions(
                          title: "Телефон",
                          visibility: state.isEditing,
                          value: itemDetails.showPhone,
                          callback: (val) {
                            showPhoneChanged(val);
                          },
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
      return Container();
    });
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

  changeItemDetails(ItemdetailsState state, Item item) {
    if ((state as ItemDetailsLoaded).isEditing) {
      // itemDetailsBloc.add(ChangeItemDetails(isEditing: false, item: item));
      itemDetailsBloc.add(SaveItemDetails(item: item));
    } else {
      // itemDetailsBloc.add(SaveItemDetails(item: item));
      itemDetailsBloc.add(ChangeItemDetails(isEditing: true, item: item));
    }
  }

  showPhoneChanged(bool value) {
    // setState(() {
    // itemDetails.showPhone = value;
    itemDetails.showPhone = value;
    itemDetailsBloc.add(UpdateItemDetails(item: itemDetails));
    // });
  }

  showEmailChanged(bool value) {
    // setState(() {
    //   itemDetails.showEmail = value;
    // });
    itemDetails.showEmail = value;
    itemDetailsBloc.add(UpdateItemDetails(item: itemDetails));
  }
}