# Nutrition App

A Flutter application for nutrition tracking and food analysis.

## Features

- Food analysis through camera
- Food diary tracking
- Recipe recommendations
- Cross-platform support (Web, iOS, Android)

## Getting Started

### Prerequisites

- Flutter (latest version)
- Dart SDK
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/nutrition_app.git
```

2. Navigate to project directory
```bash
cd nutrition_app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── core/
│   └── theme/
├── features/
│   ├── camera/
│   │   ├── presentation/
│   │   └── services/
│   └── home/
│       └── presentation/
├── app.dart
└── main.dart
```

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.



lib/
├── core/
│   ├── config/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── food_recognition/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── nutrition/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── recipes/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── app.dart
└── main.dart# nutrition_app
