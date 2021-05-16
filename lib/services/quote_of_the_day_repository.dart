import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:ufirst_flutter_test/models/quote_of_the_day.dart';

abstract class QuoteOfTheDayRepository {
  ///
  /// Returns the quote of the day for today, cached or from the corresponding Web API
  ///
  Future<QuoteOfTheDay> getQuoteOfTheDay();
}

class QuoteOfTheDayRepositoryImpl implements QuoteOfTheDayRepository {
  QuoteOfTheDay _cachedQuoteOfTheDay;

  @override
  Future<QuoteOfTheDay> getQuoteOfTheDay() async {
    // We're going to make an extremely simple mock of a cache here.. //
    if (_cachedQuoteOfTheDay == null) {
      // Creates the URI //
      // TODO possible future improvement: fetch the quote from quotes.rest based on user language
      var url = Uri.https("quotes.rest", "qod");
      // Headers to fetch a json response instead of XML //
      Map<String, String> headers = {"accept": "application/json"};
      // Starts the request //
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        try {
          // Decodes the response //
          Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
          // Gets the quote of the day from the contents //
          var quote = jsonResponse["contents"]["quotes"][0];
          // Fills the "cached" variable ith a new quote of the day //
          _cachedQuoteOfTheDay = QuoteOfTheDay(
              quote["author"] as String,
              quote["quote"] as String
          );
        } catch (e) {
          // Errors could be better handled here //
          // For the sake of this app, this try/catch will probably work fine //
        }
      }
    }
    return _cachedQuoteOfTheDay;
  }
}
