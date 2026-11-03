# Calorie Tracker

A simple Calorie Tracking app built with Flutter (Module 19 Assignment).

## Features
- Home screen with app name, today's date, and calorie summary cards
  (Total Calories, Daily Goal = 2,000 kcal, Remaining Calories)
- Add food (name + calories) with validation:
  - both fields required
  - calories must be a positive number
- Food list using `ListView.builder` with a delete button per item
- Totals update automatically on add/delete
- Data stored in a local `List` (resets on app restart); no database or API

## Project Structure
```
lib/
├── main.dart
├── models/food_item.dart
├── screens/home_screen.dart
└── widgets/
    ├── add_food_dialog.dart
    ├── food_list_item.dart
    └── summary_card.dart
```

## Run
```bash
flutter create .   # generates android/ios/web folders (first time only)
flutter pub get
flutter run
```
