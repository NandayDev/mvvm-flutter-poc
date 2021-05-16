class JournalEntry {

  JournalEntry.createNew(this.title, this.content) {
    this.creationDate = DateTime.now();
  }

  JournalEntry.withDate(this.title, this.content, this.creationDate);

  String title;
  String content;
  DateTime creationDate;

}