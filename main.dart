import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase DB CLI Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const FirebaseDBPage(),
    );
  }
}

class FirebaseDBPage extends StatefulWidget {
  const FirebaseDBPage({super.key});

  @override
  State<FirebaseDBPage> createState() => _FirebaseDBPageState();
}

class _FirebaseDBPageState extends State<FirebaseDBPage> {
  final DatabaseService _db = DatabaseService();

  void _createData() {
    _db.create(path: 'data1', data: {'name': 'Created by CLI ✨'});
  }

  void _readData() async {
    final snapshot = await _db.read(path: 'data1');
    if (snapshot != null) {
      _showSnack('Read: ${snapshot.value}');
    } else {
      _showSnack('No data found.');
    }
  }

  void _deleteData() {
    _db.delete(path: 'data1');
    _showSnack('Deleted data1');
  }

  void _showUpdateDialog() {
    final TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Data'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter something',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedValue = _textController.text.trim();
                if (updatedValue.isNotEmpty) {
                  _db.update(path: 'data1', data: {'name': updatedValue});
                  Navigator.of(context).pop();
                  _showSnack('Updated name to: $updatedValue');
                } else {
                  _showSnack('Please enter a value');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Realtime DB')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: _createData, child: const Text('Create')),
            ElevatedButton(onPressed: _showUpdateDialog, child: const Text('Update')),
            ElevatedButton(onPressed: _readData, child: const Text('Read')),
            ElevatedButton(onPressed: _deleteData, child: const Text('Delete')),
          ],
        ),
      ),
    );
  }
}
