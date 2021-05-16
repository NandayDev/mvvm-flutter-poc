import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ufirst_flutter_test/models/quote_of_the_day.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';
import 'package:ufirst_flutter_test/widgets/quote_of_the_day_viewmodel.dart';

class QuoteOfTheDayWidget extends StatefulWidget {
  ///
  /// View model for this widget
  ///
  final QuoteOfTheDayViewModel _viewModel =
      DependencyInjector.getInstance().resolve();

  @override
  _QuoteOfTheDayWidgetState createState() => _QuoteOfTheDayWidgetState();
}

class _QuoteOfTheDayWidgetState extends State<QuoteOfTheDayWidget> {
  QuoteOfTheDay _quoteOfTheDay;
  bool _errorOccurredWhileFetchingQuote = false;
  bool _isLoadingQuote;

  @override
  Widget build(BuildContext context) {
    String quote = "";
    String author = "";

    if (_errorOccurredWhileFetchingQuote) {
      // Error while fetching quote of the day //
      quote = AppLocalizations.of(context).errorWhileFetchingQuoteOfTheDay;
      author = "";
    } else if (_quoteOfTheDay == null) {
      // Quote not fetched yet: calls the repository //
      _getQuoteOfTheDayFromRepository();
    } else {
      quote = "\"${_quoteOfTheDay.quote}\"";
      author = _quoteOfTheDay.author;
    }

    return Center(
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  quote,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(""),
                Text(
                  author,
                  textAlign: TextAlign.right,
                )
              ],
            ),
          )
    ]));
  }

  void _getQuoteOfTheDayFromRepository() async {
    var quoteOfTheDay = await widget._viewModel.getQuoteOfTheDay();
    if (quoteOfTheDay == null) {
      // Error occurred while fetching quote of the day //
      stdout.writeln("errorOccurredWhileFetchingQuote");
      setState(() {
        _errorOccurredWhileFetchingQuote = true;
      });
    } else {
      // Sets the quote of the day as state //
      stdout.writeln("quote of the day ok");
      setState(() {
        _quoteOfTheDay = quoteOfTheDay;
      });
    }
  }
}
