import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entry_add_viewmodel.dart';

class JournalEntryAddWidget extends StatelessWidget {
  JournalEntryAddWidget({Key key}) : super(key: key);

  final JournalEntryAddViewModel _viewModel = DependencyInjector.getInstance().resolve();

  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        child: ListView(children: [
          Row(children: [
            Expanded(
                child: TextField(
              controller: titleTextController,
            ))
          ]),
          SizedBox(height: 30),
          Row(children: [
            Expanded(
                child: TextField(
              controller: contentTextController,
            ))
          ]),
          SizedBox(height: 30),
          TextButton(
            child: Text(AppLocalizations.of(context).saveJournalEntry),
            onPressed: () => {
              if (!_viewModel.areTitleAndContentValid(titleTextController.text, contentTextController.text)) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)
                              .journalEntryIncorrectValuesDialogTitle),
                          content: Text(AppLocalizations.of(context)
                              .journalEntryIncorrectValuesDialogContent),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context).ok),
                              onPressed: () => {},
                            )
                          ],
                        );
                      });
                } else {
                  saveJournalEntry(context)
              }
            },
          )
        ]));
  }

  void saveJournalEntry(BuildContext context) async {
    bool saved = await _viewModel.saveJournalEntry(titleTextController.text, contentTextController.text);
    if (saved) {
      Navigator.pop(context);
    } else {
      // TODO show error
    }
  }
}
