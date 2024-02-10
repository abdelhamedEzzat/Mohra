











// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
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

// class PdfViewer extends StatelessWidget {
//   const PdfViewer({Key? key}) : super(key: key);

//   // Future<void> openPdf() async {
//   //   try {
//   //     await launch(pdfUrl, forceWebView: true, enableJavaScript: true);
//   //   } catch (e) {
//   //     print("Error opening PDF: $e");
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final Uri _url = Uri.parse('https://flutter.dev');
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text('PDF Viewer'),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               try {
//                 String pdfUrl =
//                     'https://firebasestorage.googleapis.com/v0/b/mohra-project.appspot.com/o/Image%20Document%20Company%2Fa735b78c-2beb-41ce-beaa-e52fb59d9d1b5141260431010215994.jpg?alt=media&token=3a8a2ba4-a3d8-4593-a9ea-b4de556413ce';

//                 var query = "file:$pdfUrl";
//                 var uri = Uri.parse(pdfUrl);
//                 Uri.encodeComponent(pdfUrl);
//                 if (await canLaunchUrl(uri)) {
//                   await launchUrl(uri, mode: LaunchMode.inAppWebView
//                       // mode: LaunchMode.externalNonBrowserApplication
//                       );
//                 } else {
//                   print(uri);
//                 }
//               } on Exception catch (e) {
//                 print(e.toString());
//                 // TODO
//               }
//             },
//             child: const Text('Open PDF with url_launcher'),
//           ),
//         ],
//       ),
//     );
//   }
// }
