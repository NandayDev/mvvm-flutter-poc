import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ufirst_flutter_test/services/authentication_service.dart';
import 'package:ufirst_flutter_test/services/journal_entries_repository.dart';
import 'package:ufirst_flutter_test/services/quote_of_the_day_repository.dart';
import 'package:ufirst_flutter_test/widgets/home/home_viewmodel.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entries_viewmodel.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entry_add_viewmodel.dart';
import 'package:ufirst_flutter_test/widgets/quote_of_the_day/quote_of_the_day_viewmodel.dart';

///
/// Simple implementation of a dependency injector
///
class DependencyInjector {

  bool _initialized = false;
  Injector _injector;

  ///
  /// Initializes all the mappings for the D.I., for both services and view models
  ///
  void initialize() {
    _injector = Injector();

    // Services //
    _injector.map<AuthenticationService>((i) => FireBaseAuthenticationService(), isSingleton: true);
    _injector.map<QuoteOfTheDayRepository>((i) => QuoteOfTheDayRepositoryImpl(), isSingleton: true);
    _injector.map<JournalEntriesRepository>((i) => FireBaseJournalEntriesRepository(), isSingleton: true);

    // View models //
    _injector.map<HomeViewModel>((i) => HomeViewModel(resolve()));
    _injector.map<QuoteOfTheDayViewModel>((i) => QuoteOfTheDayViewModel(resolve()));
    _injector.map<JournalEntriesViewModel>((i) => JournalEntriesViewModel(resolve(), resolve()));
    _injector.map<JournalEntryAddViewModel>((i) => JournalEntryAddViewModel(resolve(), resolve()));
  }

  ///
  /// Returns an instance of requested service
  ///
  T resolve<T>() {
    return _injector.get<T>();
  }

  ///
  /// Static instance (singleton)
  ///
  static DependencyInjector _instance = DependencyInjector();

  ///
  /// Returns the singleton instance of the DependencyInjector, to be used for the D.I.
  ///
  static DependencyInjector getInstance() {
    if (!_instance._initialized) {
      _instance._initialized = true;
      _instance.initialize();
    }
    return _instance;
  }

}