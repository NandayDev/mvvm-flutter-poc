import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufirst_flutter_test/models/journal_entry.dart';

///
/// Repository for the journal entries read/write operations
///
abstract class JournalEntriesRepository {
  ///
  /// Loads the journal entries from the storage
  ///
  Future<List<JournalEntry>> getJournalEntries(String userId);

  ///
  /// Saves given journal entry to the storage
  ///
  Future<bool> saveJournalEntry(String userId, JournalEntry journalEntry);
}

class FireBaseJournalEntriesRepository implements JournalEntriesRepository {
  List<JournalEntry> _cachedJournalEntries;

  @override
  Future<List<JournalEntry>> getJournalEntries(String userId) async {
    if (_cachedJournalEntries == null) {
      _cachedJournalEntries = [];

      // Gets all journal entries for given user id /
      var snapshot = await FirebaseFirestore.instance
          .collection("journalEntries")
          .where("userId", isEqualTo: userId)
          .get();

      for (var doc in snapshot.docs) {
        // Adds a journal entry for each document returned by the backend //
        _cachedJournalEntries.add(
          JournalEntry.withDate(doc["title"], doc["content"], (doc["creationDate"] as Timestamp).toDate())
        );
      }
    }
    return _cachedJournalEntries;
  }

  @override
  Future<bool> saveJournalEntry(
      String userId, JournalEntry journalEntry) async {

    // Gets the collection reference //
    CollectionReference journalEntries =
        FirebaseFirestore.instance.collection("journalEntries");

    bool saveSuccessful = true;

    // Attempts to add the entry to the collection //
    await journalEntries
        .add({
          "userId": userId,
          "title": journalEntry.title,
          "content": journalEntry.content,
          "creationDate": journalEntry.creationDate
        })
        .then((value) => _cachedJournalEntries.add(journalEntry))
        .catchError((error) {
          saveSuccessful = false;
          print("FireBaseJournalEntriesRepository: $error");
        });

    return saveSuccessful;
  }
}
