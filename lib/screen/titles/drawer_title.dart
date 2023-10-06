import 'package:app_alugar/model/user_model.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int? page;
  DrawerTile(
      {required this.icon,
      required this.text,
      required this.pageController,
       this.page});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
        if(page != null){
            Navigator.of(context).pop();
          pageController.jumpToPage(page!);
        }else{
          UserModel.of(context).signOut();
        }
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
