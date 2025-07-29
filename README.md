# 🔥 Flutter + Firebase Realtime Database (Using Firebase CLI)

This guide explains how to connect a Flutter application to **Firebase Realtime Database** using the **Firebase CLI** and **FlutterFire CLI**.

---

## 📆 Prerequisites

* Flutter SDK installed
* Node.js & NPM installed
* Firebase project already created (via [console](https://console.firebase.google.com/) or CLI)
* Git installed (optional, for repo setup)

---

## 🧰 Step-by-Step Setup

### ✅ 1. Add Firebase Core to Flutter

```bash
flutter pub add firebase_core
```

---

### 🔥 2. Install Firebase CLI

```bash
npm install -g firebase-tools
```

Log in to Firebase:

```bash
firebase login
```

---

### 🛠️ 3. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

Verify installation:

```bash
flutterfire --version
```

---

### ⚖️ 4. Configure Firebase Project

Run this inside your Flutter project:

```bash
flutterfire configure
```

* Select your Firebase project
* Choose platforms (Android, iOS, Web, etc.)
* It generates a `firebase_options.dart` file with all your config

---

### 📁 5. Project Files Created/Updated

* `firebase_options.dart`: Contains project-specific config
* `pubspec.yaml`: Ensure the following dependencies:

```yaml
dependencies:
  firebase_core: ^2.25.0
  firebase_database: ^10.2.2
```

---

### ⚙️ 6. Initialize Firebase in `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

**Imports needed:**

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```

---

### 📊 7. Use Firebase Realtime Database

Add Firebase Database:

```bash
flutter pub add firebase_database
```

Now you can:

* Write: `ref.set(data)`
* Read: `ref.get()`
* Update: `ref.update(data)`
* Delete: `ref.remove()`

Use a service class like `database_service.dart` to encapsulate CRUD logic.

---

## 🔐 Realtime Database Rules (Testing Only)

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

> ⚠️ Do NOT use this in production.

---

## ✅ Optional Firebase CLI Commands

```bash
firebase init         # Initialize Firebase in current folder
firebase use --add    # Link to an existing Firebase project
firebase deploy       # Deploy functions/rules
```

---

## ✨ Result

You now have a Flutter app fully connected to Firebase Realtime Database using only CLI tools — no manual Firebase Console clicking required.

---

## 📚 Resources

* [FlutterFire Docs](https://firebase.flutter.dev/)
* [Firebase CLI Docs](https://firebase.google.com/docs/cli)
* [Realtime Database Rules](https://firebase.google.com/docs/database/security)

---

## 👨‍💼 Author

Made with ❤️ by Me
