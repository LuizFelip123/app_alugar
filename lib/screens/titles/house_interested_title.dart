import 'package:app_alugar/screens/interested_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HouseInterestedTitle extends StatelessWidget {
  final _houseModel;
  HouseInterestedTitle(this._houseModel);
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
          Text(
            _houseModel.interested.length.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 9,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InterestedScreen(_houseModel),
              ));
            },
            child: const Icon(
              color: Colors.white,
              CupertinoIcons.person_3,
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
