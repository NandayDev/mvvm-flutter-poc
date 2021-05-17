import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/authentication_service.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';

class JournalEntriesViewModel extends StateNotifier<JournalEntriesState> {

  static final journalEntriesProvider =
      StateNotifierProvider<JournalEntriesViewModel, JournalEntriesState>(
          (ref) {
    return DependencyInjector.getInstance().resolve<JournalEntriesViewModel>();
  });

  /// Constructor for D.I.
  JournalEntriesViewModel(this._repository, this._authenticationService)
      : super(JournalEntriesState.empty());

  /// Repository for fetching journal entries
  final JournalEntriesRepository _repository;
  /// Authentication service, to get the user's id
  final AuthenticationService _authenticationService;

  ///
  /// Loads the entries from the repository, and sets the state, to notify the view
  ///
  Future loadEntries() async {
    var entries = await _repository.getJournalEntries(_authenticationService.userId);
    state = JournalEntriesState.fromEntries(entries);
  }
}

/// State class for the view model / view
class JournalEntriesState {
  /// Empty constructor, when entries are still loading
  JournalEntriesState.empty();

  /// Constructor for loaded entries, ready to be shown
  JournalEntriesState.fromEntries(this.journalEntries) {
    this.entriesWereLoaded = true;
  }

  /// The list of entries to show to the user
  List<JournalEntry> journalEntries = [];

  /// Whether entries are still to be loaded or not
  bool entriesWereLoaded = false;
}
