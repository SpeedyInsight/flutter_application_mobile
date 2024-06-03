import 'package:flutter/material.dart';
import 'package:flutter_application_mobile/LoginPage/LoginPage.dart';
import 'package:flutter_application_mobile/HomePage/HomePage.dart';

class HalamanProfilAbhy extends StatefulWidget {
  const HalamanProfilAbhy({Key? key}) : super(key: key);

  @override
  State<HalamanProfilAbhy> createState() => _HalamanProfilAbhyState();

  
}

class _HalamanProfilAbhyState extends State<HalamanProfilAbhy> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('DataDiri'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.amber.withOpacity(.60),selectedLabelStyle: textTheme.caption,
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
                      MaterialPageRoute(builder: (context) => const LoginPage()),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage (
                    'asset/abhy.png'
                ),
                radius: 80,
              ),
              SizedBox(height: 16),
              Text(
                'PRAMANA ABHYASA WICAKSANA',
                style: TextStyle (
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber
                ),
              ),
              SizedBox(height: 8),
              Text(
                '123180135',
                style: TextStyle (
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 24),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('View Profile Details'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Nama'),
                      subtitle: Text('Pramana Abhyasa Wicaksana'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('Kelas'),
                      subtitle: Text('Praktikum Teknologi Dan Pemrograman Mobile IF-D'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Hobby'),
                      subtitle: Text('Belajar dan berdoa'),
                    ),
                    Divider(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}