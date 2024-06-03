import 'package:flutter/material.dart';
import 'package:flutter_application_mobile/LoginPage/LoginPage.dart';
import 'package:flutter_application_mobile/HomePage/HomePage.dart';

class Saran extends StatefulWidget {
  const Saran({Key? key}) : super(key: key);

  @override
  State<Saran> createState() => _SaranState();
}

class _SaranState extends State<Saran> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Saran'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.amber.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          if (value == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage()));
          }
          if (value == 1) {
            AlertDialog alert = AlertDialog(
              title: const Text("Logout"),
              content: Container(
                child: const Text("Apakah Anda Yakin Ingin Logout?"),
              ),
              actions: [
                TextButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
                TextButton(
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            showDialog(context: context, builder: (context) => alert);
          }
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Halaman Utama',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Logout',
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black, // Set background to black
        ),
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Saran',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                SizedBox(height: 8),
                Text(
                  'Kalau bisa presentasi project tidak menggunakan emulator karena memberatkan laptop. Digunakan alternatif yang ringan walaupun memang mobile terkenal berat.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
