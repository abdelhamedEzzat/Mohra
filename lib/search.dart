// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mohra_project/features/user/create_company/data/add_company_hive.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(AddCompanyToHiveAdapter());
//   await Hive.openBox<AddCompanyToHive>('companyBox');
//   runApp(const MyApppp());
// }

// class MyApppp extends StatelessWidget {
//   const MyApppp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Example'),
//         ),
//         body: PdfViewer(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyAppppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Cache Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Cache Example'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getCachedDataStream(),
        builder: (context, cachedSnapshot) {
          if (cachedSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (cachedSnapshot.hasError) {
            return Center(child: Text('Error: ${cachedSnapshot.error}'));
          }
          List<Map<String, dynamic>> cachedData = cachedSnapshot.data ?? [];
          if (cachedData.isNotEmpty) {
            print('============data From Cache================');

            return _buildListView(cachedData);
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Document').snapshots(),
              builder: (context, firebaseSnapshot) {
                if (firebaseSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (firebaseSnapshot.hasError) {
                  return Center(
                      child: Text('Error: ${firebaseSnapshot.error}'));
                }
                List<Map<String, dynamic>> firebaseData = firebaseSnapshot
                    .data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();
                _cacheData(firebaseData);
                print('============data From database================');

                return _buildListView(firebaseData);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['comment'] ?? ''),
          subtitle: Text(data[index]['companydocID'] ?? ''),
        );
      },
    );
  }

  static Stream<List<Map<String, dynamic>>> _getCachedDataStream() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedDataString = prefs.getString('cached_data');
    if (cachedDataString != null) {
      List<dynamic> cachedDataJson = json.decode(cachedDataString);
      yield cachedDataJson.cast<Map<String, dynamic>>();
    }
  }

  Future<void> _cacheData(List<Map<String, dynamic>> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(data);
    await prefs.setString('cached_data', jsonData);
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Cache Example'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _getCachedData(),
//         builder: (context, cachedSnapshot) {
//           if (cachedSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (cachedSnapshot.hasError) {
//             return Center(child: Text('Error: ${cachedSnapshot.error}'));
//           }
//           List<Map<String, dynamic>> cachedData = cachedSnapshot.data ?? [];
//           if (cachedData.isNotEmpty) {
//             print('============data From Cache================');
//             return _buildListView(cachedData);
//           } else {
//             return FutureBuilder<List<Map<String, dynamic>>>(
//               future: _fetchAndCacheData(),
//               builder: (context, firebaseSnapshot) {
//                 if (firebaseSnapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (firebaseSnapshot.hasError) {
//                   return Center(
//                       child: Text('Error: ${firebaseSnapshot.error}'));
//                 }
//                 List<Map<String, dynamic>> firebaseData =
//                     firebaseSnapshot.data ?? [];
//                 print('============data From firebase================');
//                 return _buildListView(firebaseData);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildListView(List<Map<String, dynamic>> data) {
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(data[index]['comment'] ?? ''),
//           subtitle: Text(data[index]['companydocID'] ?? ''),
//         );
//       },
//     );
//   }

//   Future<List<Map<String, dynamic>>> _getCachedData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? cachedDataString = prefs.getString('cached_data');
//     if (cachedDataString != null) {
//       List<dynamic> cachedDataJson = json.decode(cachedDataString);
//       return cachedDataJson.cast<Map<String, dynamic>>();
//     } else {
//       return [];
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchAndCacheData() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('Document').get();
//     List<Map<String, dynamic>> data = querySnapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String jsonData = json.encode(data);
//     await prefs.setString('cached_data', jsonData);
//     return data;
//   }
// }
