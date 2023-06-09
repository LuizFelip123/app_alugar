import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class BarraBusca extends StatelessWidget {
  Function(String text) search;
  String text = "";
  BarraBusca(this.search);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffe0e0e0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.search,
                ),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: "Buscar casa por Cidade",
                    autocorrect: true,
                    onChanged: (value) {
                      search(value);
                    },
                    decoration: BoxDecoration(),
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.clear_circled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
