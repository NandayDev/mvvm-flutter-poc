import 'package:ufirst_flutter_test/models/journal_entry.dart';

abstract class JournalEntriesRepository {

  ///
  /// Loads the journal entries from the storage
  ///
  Future<List<JournalEntry>> getJournalEntries();

  ///
  /// Saves given journal entry to the storage
  ///
  Future<bool> saveJournalEntry(JournalEntry journalEntry);
}

class JournalEntriesRepositoryImpl implements JournalEntriesRepository {

  List<JournalEntry> _cachedJournalEntries;

  @override
  Future<List<JournalEntry>> getJournalEntries() async {
    if (_cachedJournalEntries == null) {
      // TODO: get journal entries from firebase
      await Future.delayed(Duration(seconds: 2));
      _cachedJournalEntries = [];
    }
    return _cachedJournalEntries;
  }

  @override
  Future<bool> saveJournalEntry(JournalEntry journalEntry) async {
    // TODO: save journal entry to firebase
    await Future.delayed(Duration(seconds: 2));

    _cachedJournalEntries.add(journalEntry);

    return true;
  }

}