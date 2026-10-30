# Part 3 checklist (do these on your own phone or emulator)

Force-kill = swipe the app away in recent apps, then reopen from the home screen.
Hot reload / hot restart / stopping from the IDE do NOT count.
Run a debug build (`flutter run`) so the console prints the database rows.

| # | Do this | Circle this |
|---|---------|-------------|
| 1 | Screenshot light mode, flip the switch, screenshot dark mode | The theme switch (top right) |
| 2 | Set dark, screenshot, force-kill, reopen, screenshot | The dark theme, on both shots |
| 3 | Add 3 contacts. FIRST one has YOUR NAME. Screenshot the list | Your name |
| 4 | Force-kill, reopen, screenshot the same list | The record with your name |
| 5 | Screenshot before editing, tap a contact, change it, screenshot after | The changed text |
| 6 | Screenshot before deleting, delete one, screenshot after | The spot where the record was |
| 7 | Screenshot the console line `DB rows -> [...]` (or Android Studio > App Inspection > Database Inspector > contacts) NEXT TO the app list | Matching rows |
| 8 | Open lib/models/contact_db.dart and screenshot the `delete` method | `where: 'id = ?'` and `whereArgs: [id]` |

Tips
- The console line prints after every load, add, edit and delete.
- Keep the first record's name unchanged; it is what graders look for.
- Submit: one PDF, plus the GitHub repo link.
