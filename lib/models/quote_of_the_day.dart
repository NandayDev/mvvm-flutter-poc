///
/// Simple model class for the quote of the day
/// Expandable with other properties, if necessary
///
class QuoteOfTheDay {
  QuoteOfTheDay(this.author, this.quote);

  ///
  /// Author of the quote
  ///
  final String author;

  ///
  /// Quote (exact words: what the author said)
  ///
  final String quote;
}