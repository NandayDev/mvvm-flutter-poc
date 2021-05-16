import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalEntriesWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2; /*3*/

          if (index >= _passwords.length) {
            return null;
            // _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return PasswordListElement(_passwords[index], widget.repository,
                  (element) {
                setState(() {
                  _passwords = List.from(_passwords)
                    ..removeAt(_passwords.indexOf(element));
                });
              });
        }),
    floatingActionButton: FloatingActionButton(
      tooltip: "",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PasswordCreationPage.createNew()));
      },
    ))
  }
}
