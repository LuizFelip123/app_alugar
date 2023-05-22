import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HouseTitle extends StatelessWidget {
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
              "https://www.maahsareiaebrita.com.br/wp-content/uploads/2020/02/asiatica.jpg",
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
                  Text(
                    "Casa",
                    style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),

                  ),
                  Text("Em Santo Antônio de Jesus"),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    'R\$ 250,00',
                  )
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(
              CupertinoIcons.arrow_right_square_fill,
                size:35,
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
