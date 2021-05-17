class JournalEntry {
  ///
  /// Creates a new journal entry, with today's date
  ///
  JournalEntry.createNew(this.title, this.content) {
    this.creationDate = DateTime.now();
  }

  ///
  /// Creates a journal entry with a specific creation date
  ///
  JournalEntry.withDate(this.title, this.content, this.creationDate);

  ///
  /// Title of the journal entry
  ///
  String title;

  ///
  /// Content of the journal entry
  ///
  String content;

  ///
  /// Creation date of this entry
  ///
  DateTime creationDate;
}
