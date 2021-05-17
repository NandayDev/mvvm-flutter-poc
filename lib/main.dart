import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ufirst_flutter_test/widgets/journal_entries/journal_entries_widget.dart';
import 'package:ufirst_flutter_test/widgets/quote_of_the_day/quote_of_the_day_widget.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // Localization //
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.format_quote)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
            title: AppTabTitle(),
          ),
          body: TabBarView(
            children: [
              QuoteOfTheDayWidget(),
              JournalEntriesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTabTitle extends StatelessWidget {
  const AppTabTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context).appName);
  }
}
