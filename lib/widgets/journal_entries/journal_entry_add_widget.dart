import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entry_add_viewmodel.dart';

class JournalEntryAddWidget extends StatelessWidget {
  JournalEntryAddWidget({Key key}) : super(key: key);

  final JournalEntryAddViewModel _viewModel = DependencyInjector.getInstance().resolve();

  final _titleTextController = TextEditingController();
  final _contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context).journalEntryAddPageTitle)),
        body: Container(
            margin: EdgeInsets.all(15),
            child: ListView(children: [
              Row(children: [
                Expanded(
                    child: JournalEntryAddTextField(
                        Key("title"),
                        _titleTextController,
                        AppLocalizations.of(context).journalEntryAddTitleHint))
              ]),
              SizedBox(height: 30),
              Row(children: [
                Expanded(
                    child: JournalEntryAddTextField(
                        Key("content"),
                        _contentTextController,
                        AppLocalizations.of(context).journalEntryAddContentHint))
              ]),
              SizedBox(height: 30),
              TextButton(
                child: Text(AppLocalizations.of(context).saveJournalEntry),
                onPressed: () => {
                  if (!_viewModel.areTitleAndContentValid(
                      _titleTextController.text, _contentTextController.text))
                    {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context).journalEntryIncorrectValuesDialogTitle),
                              content: Text(AppLocalizations.of(context).journalEntryIncorrectValuesDialogContent),
                              actions: [
                                TextButton(
                                  child: Text(AppLocalizations.of(context).ok),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            );
                          })
                    }
                  else
                    {saveJournalEntry(context)}
                },
              )
            ])));
  }

  void saveJournalEntry(BuildContext context) async {
    bool saved = await _viewModel.saveJournalEntry(
        _titleTextController.text, _contentTextController.text);
    if (saved) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).error),
              content: Text(AppLocalizations.of(context)
                  .journalEntrySaveErrorDialogContent),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () => Navigator.pop(context)
                )
              ],
            );
          });
    }
  }
}

class JournalEntryAddTextField extends StatelessWidget {
  JournalEntryAddTextField(Key key, this._textController, this._hint)
      : super(key: key);

  final TextEditingController _textController;
  final String _hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: _hint,
          hintStyle: TextStyle(color: Colors.black45),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2))),
    );
  }
}
