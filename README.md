# Smart Farmer Assistant

A Flutter-based mobile application prototype that brings together location-based weather information and an agriculture-focused chatbot in a farmer-oriented interface.

## Current Features

- **Firebase authentication:** Google Sign-In through Firebase Authentication.
- **User profile storage:** Saves basic signed-in user details in Cloud Firestore.
- **Location-based weather:** Requests the device's current location and retrieves current weather conditions from WeatherAPI.
- **Agriculture chatbot interface:** Lets users submit farming-related questions through a chat UI. The service code is configured to call Groq's chat-completions API using the Llama 3.3 70B Versatile model.
- **Crop image selection:** Lets users capture a crop image using the camera or choose one from the gallery.
- **Farmer-oriented interface:** Dashboard and selected interface labels support English and Telugu.

## Important Scope Notes

This repository is a prototype, not a complete precision-agriculture platform.

- The Crop Doctor currently supports image selection and navigation to an analysis screen; it does **not** currently run a trained disease-classification model. Disease predictions and confidence scores should not be treated as available functionality.
- Soil Analysis, Crop Recommendation, Market Prices, Farm Diary, Government Schemes, and the separate Weather dashboard cards are currently placeholders and are not implemented workflows.
- The weather integration retrieves current conditions; forecast alerts and notifications are not implemented.
- The chatbot requires a valid Groq API key. The current source contains a placeholder value, so the chatbot will not work against Groq until configuration is corrected.
- Automated testing is currently limited to a basic app-load widget test.

## Tech Stack

- **Language:** Dart
- **UI framework:** Flutter
- **Authentication:** Firebase Authentication with Google Sign-In
- **User data:** Cloud Firestore
- **Location:** Geolocator
- **Weather:** WeatherAPI
- **Chatbot API:** Groq API (Llama 3.3 70B Versatile)
- **Image input:** image_picker
- **Networking:** http

## Project Structure

```text
lib/
  app.dart
  main.dart
  core/
  models/
  screens/
    auth/
    chatbot/
    crop_doctor/
    home/
    language/
    onboarding/
    splash/
  services/
  widgets/
assets/
  images/
test/
```

## Run Locally

### Prerequisites

- Flutter SDK compatible with the Dart SDK constraint in `pubspec.yaml`
- Android Studio or VS Code with Flutter tooling
- A configured Firebase project with the required Android/iOS app registrations
- A valid WeatherAPI key
- A valid Groq API key for chatbot requests

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/koushikturlapati/smart_farmer_assistant.git
   cd smart_farmer_assistant
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase for your target platform and provide the generated platform configuration required by FlutterFire.

4. Configure API credentials securely before running the app. Do not commit API keys or other secrets to source control. The current source includes a hardcoded WeatherAPI credential and a placeholder Groq credential; rotate the exposed WeatherAPI credential and replace the current credential handling before using or publishing this project.

5. Run the application:

   ```bash
   flutter run
   ```

## Run Tests

Run the available Flutter tests with:

```bash
flutter test
```

Run static analysis with:

```bash
flutter analyze
```

The presence of these commands in this README does not imply that a comprehensive test suite or CI pipeline is already in place.

## Repository

[GitHub: koushikturlapati/smart_farmer_assistant](https://github.com/koushikturlapati/smart_farmer_assistant)
