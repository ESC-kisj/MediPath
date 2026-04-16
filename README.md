# MediPath

Collaborative app project with KISJ Biosci &amp; Globalaid Club.

Originally based on the "MultiCult" Flutter application for improving medical access for Jeju's multicultural population.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## Technical Stack

- **Framework**: Flutter 3.8.0+
- **Language**: Dart
- **UI Components**: Material Design
- **State Management**: StatefulWidget with setState
- **Platform Support**: iOS, Android, Web, macOS, Linux, Windows

## Getting Started

### Prerequisites

- Flutter SDK (3.8.0 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ)
- For mobile development: Android Studio/Xcode

### Installation

1. Clone the repository:
```bash
git clone https://github.com/easycomputingclub/MediPath.git
cd MediPath
```

2. Install dependencies:
```bash
flutter pub get
```

3. (Optional) Set up OpenAI API integration:
```bash
# Copy the environment template
cp .env.example .env

# Edit .env and add your OpenAI API key
# OPENAI_API_KEY=your_actual_api_key_here
```

4. Run the app:
```bash
flutter run
```

### Building for Different Platforms

- **Android**: `flutter build apk`
- **iOS**: `flutter build ios`
- **Web**: `flutter build web`
- **macOS**: `flutter build macos`
- **Linux**: `flutter build linux`
- **Windows**: `flutter build windows`

## Project Structure

```
lib/
├── main.dart           # Entry point and navigation
├── home.dart           # Home screen implementation
├── quiz.dart           # Quiz functionality with typing and MCQ
├── chat.dart           # AI-powered chat with OpenAI integration
├── settings.dart       # Settings page with editable fields
├── globals.dart        # Global variables and data
└── openai_service.dart # OpenAI API integration service
```

## Key Features

### AI-Powered Chat
- **OpenAI Integration**: Real-time conversations with GPT models
- **Language Learning Focus**: Specialized prompts for multicultural language learning
- **Loading States**: Visual feedback during API calls
- **Error Handling**: Graceful fallbacks for network issues

### Interactive Quiz System
- **Multiple Question Types**: MCQ, typing, and matching questions
- **Answer Validation**: Smart checking with override options
- **Responsive UI**: Fixed text input and overflow issues
- **Progress Tracking**: Visual feedback and scoring

### Editable Settings
- **Text Fields**: Email and name editing through dialog boxes
- **Birth Year Picker**: Smooth scrollable wheel picker for year selection
- **Language Selection**: Expandable dropdown with flag and name display

### Multi-Platform Support
- Responsive design for different screen sizes
- Platform-specific adaptations
- Consistent user experience across devices

## Authors

- Joy Kim
- Sang Ahn
- Ethan Cho
- Soomin Kim
- Alisa Kim
- Zijun Huang
