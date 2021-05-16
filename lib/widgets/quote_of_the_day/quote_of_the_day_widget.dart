import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ufirst_flutter_test/widgets/quote_of_the_day/quote_of_the_day_viewmodel.dart';

class QuoteOfTheDayWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final QuoteOfTheDayState state = watch(QuoteOfTheDayViewModel.quoteOfTheDayProvider);
    var viewModel = context.read(QuoteOfTheDayViewModel.quoteOfTheDayProvider.notifier);

    String quote = "";
    String author = "";

    if (state.errorOccurredWhileFetchingQuote) {
      // Error while fetching quote of the day //
      quote = AppLocalizations.of(context).errorWhileFetchingQuoteOfTheDay;
    } else if (state.isLoadingQuote) {
      // Quote not fetched yet: calls the repository //
      viewModel.getQuoteOfTheDay();
    } else {
      quote = state.quote;
      author = state.author;
    }

    return Center(
        child: state.isLoadingQuote
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quote,
                      style: TextStyle(
                          fontSize: 20.0, fontStyle: FontStyle.italic),
                    ),
                    Text(""),
                    Text(
                      author,
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              )
    );
  }
}
