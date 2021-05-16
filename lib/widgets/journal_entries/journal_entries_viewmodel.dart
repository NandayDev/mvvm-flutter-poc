import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';

class JournalEntriesViewModel extends StateNotifier<JournalEntriesState>  {

  static final journalEntriesProvider = StateNotifierProvider<JournalEntriesViewModel, JournalEntriesState>((ref) {
    return DependencyInjector.getInstance().resolve<JournalEntriesViewModel>();
  });

  /// Constructor for D.I.
  JournalEntriesViewModel(this._repository) : super(JournalEntriesState.empty());

  /// Repository for fetching journal entries
  final JournalEntriesRepository _repository;

  ///
  /// Loads the entries from the repository, and sets the state, to notify the view
  ///
  void loadEntries() async {
    var entries = await _repository.getJournalEntries();
    state = JournalEntriesState.fromEntries(entries);
  }
}

class JournalEntriesState {

  JournalEntriesState.empty();

  JournalEntriesState.fromEntries(this.journalEntries);

  List<JournalEntry> journalEntries = [];
}