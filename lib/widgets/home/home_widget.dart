import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ufirst_flutter_test/widgets/home/home_viewmodel.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entries_widget.dart';
import 'package:ufirst_flutter_test/widgets/quote_of_the_day/quote_of_the_day_widget.dart';

class HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final HomeState state = watch(HomeViewModel.homeProvider);
    var viewModel = context.read(HomeViewModel.homeProvider.notifier);

    if (state.isAuthenticated == null) {
      if (!state.isAuthenticationInProgress) {
        // Authentication has yet to start //
        viewModel.startAuthentication();
      }
      // Shows a progress indicator //
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!state.isAuthenticated) {
      // Failed authentication //
      return Scaffold(
          appBar: AppBar(),
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).loginError,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).loginErrorTryAgain),
                  onPressed: (() => {viewModel.startAuthentication()}),
                )
              ],
            ),
          ));
    }

    // Authenticated: can show the home page //
    // Shows a toast first //
    showLoginToast(AppLocalizations.of(context).loginSuccessful);

    // Then returns the home page //
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.format_quote)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
          title: Text(AppLocalizations.of(context).appName),
        ),
        body: TabBarView(
          children: [
            QuoteOfTheDayWidget(),
            JournalEntriesWidget(),
          ],
        ),
      ),
    );
  }

  ///
  /// Shows a toast with a message (failed or successful authentication)
  ///
  void showLoginToast(String textToShow) async {
    await Future.delayed(Duration(milliseconds: 500));
    Fluttertoast.showToast(
        msg: textToShow,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
