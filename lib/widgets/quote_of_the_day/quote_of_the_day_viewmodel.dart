import 'package:riverpod/riverpod.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/services/quote_of_the_day_repository.dart';

///
/// View model for the Quote of the day widget
///
class QuoteOfTheDayViewModel extends StateNotifier<QuoteOfTheDayState> {

  static final quoteOfTheDayProvider = StateNotifierProvider<QuoteOfTheDayViewModel, QuoteOfTheDayState>((ref) {
    return DependencyInjector.getInstance().resolve<QuoteOfTheDayViewModel>();
  });

  ///
  /// Constructor via dependency injection
  ///
  QuoteOfTheDayViewModel(this._repository) : super(QuoteOfTheDayState());

  ///
  /// Repository for the quote of the day
  ///
  final QuoteOfTheDayRepository _repository;

  ///
  /// Fetches the quote of the day from the repository and fills the viewmodel's properties
  /// Then notifies the view of the change occurred
  ///
  void getQuoteOfTheDay() async {
    var quoteOfTheDay = await _repository.getQuoteOfTheDay();
    var newState = QuoteOfTheDayState();
    newState.isLoadingQuote = false;
    if (quoteOfTheDay == null) {
      newState.errorOccurredWhileFetchingQuote = true;
    } else {
      newState.quote = "\"${quoteOfTheDay.quote}\"";
      newState.author = quoteOfTheDay.author;
    }
    state = newState;
  }
}

///
/// State class for the view model, containing all relevant properties
///
class QuoteOfTheDayState {
  String quote = "";
  String author = "";
  bool errorOccurredWhileFetchingQuote = false;
  bool isLoadingQuote = true;
}