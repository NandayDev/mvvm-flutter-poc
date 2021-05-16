import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';

class JournalEntryAddViewModel {

  JournalEntryAddViewModel(this._repository);

  final JournalEntriesRepository _repository;

  bool areTitleAndContentValid(String title, String content) {
    return title.isNotEmpty && content.isNotEmpty;
  }

  Future<bool> saveJournalEntry(String title, String content) {
    var journalEntry = JournalEntry.createNew(title, content);
    return _repository.saveJournalEntry(journalEntry);
  }
}