import 'package:ufirst_flutter_test/models/quote_of_the_day.dart';
import 'package:ufirst_flutter_test/services/quote_of_the_day_repository.dart';

///
/// View model for the Quote of the day widget
///
class QuoteOfTheDayViewModel {

  ///
  /// Constructor via dependency injection
  ///
  QuoteOfTheDayViewModel(this._repository);

  ///
  /// Repository for the quote of the day
  ///
  final QuoteOfTheDayRepository _repository;

  ///
  /// Returns the string of the quote of the day from the repository
  ///
  Future<QuoteOfTheDay> getQuoteOfTheDay() {
    return _repository.getQuoteOfTheDay();
  }
}