import 'package:app_alugar/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InterestedTitle extends StatelessWidget {
  final UserModel _userModel;
  InterestedTitle(this._userModel);

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
          Expanded(
              child: Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                color: Colors.black,
                onPressed: () {},
                child: const Icon(
                  color: Colors.white,
                  CupertinoIcons.person_crop_circle,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 9,
              ),
              Text(
                _userModel.name!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          SizedBox(
            width: 9,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            onPressed: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailLaunchUri  = Uri(
                scheme: 'mailto',
                path:_userModel.email,
                query: encodeQueryParameters(<String, String>{
                  'Subject': 'Casa para Alugar',
                }),
              );
               launchUrl(emailLaunchUri);
            },
            child: const Icon(
              color: Colors.white,
              CupertinoIcons.bubble_middle_bottom_fill,
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
