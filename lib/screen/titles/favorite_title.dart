import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/house/house_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteTitle extends StatelessWidget {
  final  _houseModel;
  FavoriteTitle(
    this._houseModel,
  );
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
              _houseModel.imgsLink[0],
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
                  Text(_houseModel.cidade!),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    'R\$ ${_houseModel.valor!.toStringAsFixed(2).replaceAll('.', ",")}',
                  )
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              UserModel.of(context).removeFavorite(_houseModel);
            },
            child: const Icon(
              CupertinoIcons.delete,
              size: 35,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HouseScreen(_houseModel),
                ),
              );
            },
            child: const Icon(
              CupertinoIcons.arrow_right_square_fill,
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
