import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ufirst_flutter_test/models/journal_entry.dart';
import 'package:ufirst_flutter_test/services/authentication_service.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entries_viewmodel.dart';

///
/// Journal entries mock repository
///
class JournalEntriesRepositoryMock extends Mock implements JournalEntriesRepository {}

///
/// Authentication service mock
///
class AuthenticationServiceMock extends Mock implements AuthenticationService {}

void main() {

  JournalEntriesRepository repository = JournalEntriesRepositoryMock();
  AuthenticationService authenticationService = AuthenticationServiceMock();

  var journalEntries = [
    JournalEntry.withDate("title 1", "content 1", DateTime(2017, 9, 7, 17, 30)),
    JournalEntry.withDate("title 2", "content 2", DateTime(2018, 9, 7, 17, 30)),
  ];
  
  when(repository.getJournalEntries("userId")).thenAnswer((_) => Future.value(journalEntries));
  when(authenticationService.userId).thenReturn("userId");

  var viewModel = JournalEntriesViewModel(repository, authenticationService);

  test("load entries", () async {
    expect(viewModel.state.entriesWereLoaded, false);
    expect(viewModel.state.journalEntries.length, 0);
    await viewModel.loadEntries();
    expect(viewModel.state.journalEntries, journalEntries);
    expect(viewModel.state.entriesWereLoaded, true);
  });

}