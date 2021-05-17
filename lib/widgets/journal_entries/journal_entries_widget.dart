import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'journal_entries_viewmodel.dart';
import 'journal_entry_add_widget.dart';

class JournalEntriesWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final JournalEntriesState state =
        watch(JournalEntriesViewModel.journalEntriesProvider);

    final JournalEntriesViewModel viewModel = context.read(JournalEntriesViewModel.journalEntriesProvider.notifier);

    if (!state.entriesWereLoaded) {
      // Starts the entries loading, since they weren't loaded yet //
      viewModel.loadEntries();
    }

    return Scaffold(
        body: !state.entriesWereLoaded
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, i) {
                  if (i.isOdd) return Divider();

                  final index = i ~/ 2;

                  if (index >= state.journalEntries.length) {
                    return null;
                  }
                  return JournalEntryListElementWidget(
                      state.journalEntries[index].title,
                      state.journalEntries[index].content);
                }),
        floatingActionButton: FloatingActionButton(
          tooltip: "",
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JournalEntryAddWidget()));
          },
        ));
  }
}

class JournalEntryListElementWidget extends StatelessWidget {
  JournalEntryListElementWidget(this.title, this.content);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(content)
        ],
      ),
    );
  }
}
