import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/models/user.dart';
import 'package:flutter_losses/screens/itemDetails/bloc/itemdetails_bloc.dart';
import 'package:flutter_losses/utils/constants.dart';
import 'package:neumorphic/neumorphic.dart';
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
  User user;
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  Item itemDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemDetailsBloc = BlocProvider.of<ItemdetailsBloc>(context);
    itemDetailsBloc.add(GetItemDetails(item: widget.item));
    user = ((BlocProvider.of<AuthBloc>(context).state) as Authenticated).user;
    user.email ??= "";
    user.phone ??= "";
  }

  @override
  Widget build(BuildContext context) {
    final String link =
        // ignore: lines_longer_than_80_chars
        '${ConfigStorage.baseUrl}?q=11';
    QrPainter qrcode = QrPainter(
      data: link,
      version: QrVersions.auto,
      color: Color(0xFF0D1B40),
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
        itemDetails.showPhone ??= false;
        itemDetails.showEmail ??= false;

        return Scaffold(
            // appBar: PreferredSize(
            //     preferredSize: Size.fromHeight(40.0),
            //     child: AppBar(
            //       // title: Text("Вещь"),
            //       actions: <Widget>[
            //         Container(
            //           // padding: EdgeInsets.all(16),
            //           // height: 40,
            //           child: NeumorphicButton(
            //             child: state.isEditing
            //                 ? Icon(
            //                     Icons.save,

            //                   )
            //                 : Icon(Icons.mode_edit),
            //             onPressed: () => changeItemDetails(state, widget.item),
            //           ),
            //         )
            //         // IconButton(
            //         //   icon: state.isEditing
            //         //       ? Icon(Icons.save)
            //         //       : Icon(Icons.mode_edit),
            //         //   onPressed: () => changeItemDetails(state, widget.item),
            //         // )
            //       ],
            //     )),

            body: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        // Container(
                        //   height: 20,
                        //   child: NeumorphicButton(
                        //     child: state.isEditing
                        //         ? Icon(Icons.save)
                        //         : Icon(Icons.mode_edit),
                        //     onPressed: () =>
                        //         changeItemDetails(state, widget.item),
                        //   ),
                        // ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            NeumorphicButton(
                                child: Icon(
                                  Icons.arrow_back,
                                ),
                                onPressed: () => Navigator.of(context).pop()),
                            NeumorphicButton(
                              child: state.isEditing
                                  ? Icon(
                                      Icons.save,
                                    )
                                  : Icon(Icons.mode_edit),
                              onPressed: () =>
                                  changeItemDetails(state, widget.item),
                            ),
                          ],
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: Color(0xFF0D1B40),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          enabled: state.isEditing ? true : false,
                          controller: itemNameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: "Название"),
                          onChanged: (val) => itemDetails.itemName = val,
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
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(link),
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () => Clipboard.setData(
                                  new ClipboardData(text: link)),
                            )
                          ],
                        )),
                        RaisedButton(
                            child: Text("Share"),
                            onPressed: () => shareObject(qrcode)),
                        TextFormField(
                          enabled: state.isEditing ? true : false,
                          controller: itemDescriptionController,
                          decoration:
                              new InputDecoration(labelText: 'Описание'),
                          onChanged: (val) => itemDetails.itemDescription = val,
                        ),
                        ItemOptions(
                          title: "Email",
                          value: itemDetails.showEmail,
                          contact: user.email,
                          isEditing: state.isEditing,
                          callback: (val) {
                            showEmailChanged(val);
                          },
                        ),
                        ItemOptions(
                          title: "Телефон",
                          contact: user.phone,
                          isEditing: state.isEditing,
                          value: itemDetails.showPhone,
                          callback: (val) {
                            showPhoneChanged(val);
                          },
                        ),
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
      'qr image',
      'qr.png',
      bytes.buffer.asUint8List(),
      'qr/png',
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
