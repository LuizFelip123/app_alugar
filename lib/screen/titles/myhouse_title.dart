import 'package:app_alugar/model/house_share_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHouseTitle extends StatefulWidget {
  final HouseShareModel _houseModel;
  final Function(HouseShareModel houseModel, BuildContext context) _delete;
  MyHouseTitle(this._houseModel, this._delete);
  @override
  State<MyHouseTitle> createState() => _MyHouseTitleState();
}

class _MyHouseTitleState extends State<MyHouseTitle> {
  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              widget._houseModel.imgsLink[0],
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Casa",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(widget._houseModel.cidade!),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    'R\$ ${widget._houseModel.valor!.toStringAsFixed(2).replaceAll('.', ",")}',
                  )
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            color: Colors.red,
            onPressed: () {
              widget._delete(widget._houseModel, context);
              setState(() {});
            },
            child: const Icon(
              CupertinoIcons.delete,
              size: 35,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            color: Colors.blue,
            onPressed: () {},
            child: const Icon(
              color: Colors.white,
              CupertinoIcons.pencil,
              size: 35,
            ),
          ),
        ],
      ),
    );

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
          ),
        ),
      ],
    );
  }
}
