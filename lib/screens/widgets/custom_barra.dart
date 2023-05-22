import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';


class BarraBusca extends StatelessWidget {
 

 
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffe0e0e0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            
            children: [
              const Icon(
                CupertinoIcons.search,
              ),
              Expanded(
                child: CupertinoTextField(
                 
                  decoration: BoxDecoration(),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}