# 5500 English Sentences App 📚

## Overview 🌟
5500 English Sentences is a Flutter-based mobile application designed to help users learn English by memorizing full sentences rather than individual words. This app focuses on practical, everyday language use, incorporating text-to-speech functionality, quizzes, and a rich dictionary, making it an essential tool for English learners.

Features 🚀
- Daily Life Sentences: Over 5000 commonly used sentences in daily life, translated into Arabic.
- Job-Specific Sentences: Essential sentences for various professions, with Arabic translations and text-to-speech.
- American Movie Clips: Learn English through video clips from American movies, with both English and Arabic text, and the ability to hear the sentences.
- Quizzes: Test your knowledge with multiple-choice quizzes based on the sentences.
- English-Arabic Dictionary: Search for any English word and get the Arabic translation.
- Text-to-Speech: Listen to the correct pronunciation of English sentences.
- WebView Integration: Seamlessly integrated web views for additional content.
## Installation 📲
To run this app locally, follow these steps:

- Clone the repository:
  git clone https://github.com/yourusername/5500-English-Sentences-App.git
  cd 5500-English-Sentences-App
- Install dependencies:

flutter pub get

- Run the app:

flutter run

## Technology Stack 🛠️
- Flutter: The UI toolkit used to build the app for iOS and Android.
- Provider: State management solution.
- JSON: Used for loading local data.
- WebView: For integrating web content.
- Text-to-Speech: For reading out sentences.
## Project Structure 📂
bash
Copy code
lib/
│
├── main.dart                   # App entry point
├── models/                     # Data models
├── providers/                  # State management using Provider
├── screens/                    # UI screens
│   ├── home_screen.dart        # Main screen of the app
│   ├── word_screen.dart        # Displays words with TTS and quizzes
│   └── quiz_screen.dart        # Quiz screen with scoring
├── widgets/                    # Custom widgets
└── assets/                     # JSON files and other assets
# Contributing 🤝
We welcome contributions! Please fork the repository and submit a pull request. Before contributing, ensure you have followed the contributing guidelines.

# License 📄
This project is licensed under the MIT License - see the LICENSE file for details.

# Contact 📧
If you have any questions, feel free to contact us at ahmedelbehiry52@gmail.com.
