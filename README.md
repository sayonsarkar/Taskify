# Local Data App

A Flutter application for managing and storing data locally on your device. This app provides a simple and efficient way to handle local data storage using various persistence methods.

## Features

- Local data storage using SQLite database
- Shared preferences for simple key-value storage
- Material Design UI
- State management using Provider
- Cross-platform support (iOS, Android, Web, Desktop)

## Prerequisites

- Flutter SDK (version 3.7.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code (recommended IDE)

## Getting Started

1. Clone the repository:

```bash
git clone [repository-url]
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Project Structure

- `lib/` - Contains the main application code
- `android/` - Android-specific files
- `ios/` - iOS-specific files
- `web/` - Web-specific files
- `windows/`, `macos/`, `linux/` - Desktop platform files

## Dependencies

- `intl` - For internationalization and formatting
- `path` - For handling file paths
- `path_provider` - For accessing device file system
- `provider` - For state management
- `shared_preferences` - For simple key-value storage
- `sqflite` - For SQLite database operations

## Development

To start development:

1. Make sure you have Flutter installed and set up
2. Open the project in your preferred IDE
3. Run `flutter pub get` to install dependencies
4. Use `flutter run` to start the app in debug mode

## Building for Production

To build the app for different platforms:

- Android: `flutter build apk`
- iOS: `flutter build ios`
- Web: `flutter build web`
- Windows: `flutter build windows`
- macOS: `flutter build macos`
- Linux: `flutter build linux`
