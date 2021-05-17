import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/authentication_service.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';

class JournalEntryAddViewModel {

  JournalEntryAddViewModel(this._repository, this._authenticationService);

  final JournalEntriesRepository _repository;
  final AuthenticationService _authenticationService;

  ///
  /// Whether the given strings of title and content from the view are valid or not
  ///
  bool areTitleAndContentValid(String title, String content) {
    return title.isNotEmpty && content.isNotEmpty;
  }

  ///
  /// Creates and saves the journal entry, via the repository
  ///
  Future<bool> saveJournalEntry(String title, String content) {
    var journalEntry = JournalEntry.createNew(title, content);
    return _repository.saveJournalEntry(_authenticationService.userId, journalEntry);
  }
}