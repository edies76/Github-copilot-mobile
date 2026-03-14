# Development Guide

## Prerequisites

- Flutter 3.41.4 or higher
- Dart 3.11.1 or higher
- Android SDK (for Android development)
- Xcode (for iOS development on macOS)
- Git

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/edies76/Github-copilot-mobile.git
cd Github-copilot-mobile
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the application

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── github_user.dart
│   └── chat_message.dart
├── services/                 # Business logic and API integration
│   ├── auth_service.dart
│   ├── copilot_service.dart
│   └── database_service.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   └── chat_provider.dart
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   └── settings_screen.dart
└── widgets/                  # Reusable widgets
```

## Development Workflow

### 1. Create a feature branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Make your changes

- Follow Dart style guidelines
- Write unit tests for new features
- Update documentation as needed

### 3. Run tests

```bash
flutter test
```

### 4. Analyze code

```bash
flutter analyze
```

### 5. Format code

```bash
dart format lib/
```

### 6. Commit and push

```bash
git add .
git commit -m "feat: Add your feature description"
git push origin feature/your-feature-name
```

### 7. Create a Pull Request

Open a pull request on GitHub for review.

## Building for Production

### Android

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Debugging

### Enable debug logging

```bash
flutter run -v
```

### Use DevTools

```bash
flutter pub global activate devtools
devtools
```

Then run your app with:

```bash
flutter run --devtools-server-address localhost:9100
```

## Testing

### Run all tests

```bash
flutter test
```

### Run specific test file

```bash
flutter test test/services_test.dart
```

### Run tests with coverage

```bash
flutter test --coverage
```

## Common Issues

### Build fails with "Gradle build failed"

- Clean the build: `flutter clean`
- Get dependencies again: `flutter pub get`
- Rebuild: `flutter build apk`

### iOS build fails

- Clean build: `flutter clean`
- Update pods: `cd ios && pod repo update && cd ..`
- Rebuild: `flutter build ios`

### Hot reload not working

- Stop the app and run `flutter run` again
- Or use `R` key to hot reload manually

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests
5. Submit a pull request

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [GitHub Copilot API](https://docs.github.com/en/copilot)

## Support

For issues and questions, please open an issue on GitHub.
