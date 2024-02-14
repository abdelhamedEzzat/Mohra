// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/generated/l10n.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DetailsDocuments extends StatelessWidget {
  const DetailsDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    var documentUploaded = ModalRoute.of(context)?.settings.arguments;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic> doc =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        appBar: CustomAppBarForUsers(
          leading: const BackButton(color: Colors.white),
          title: Text(
            S.of(context).DetailsDocuments,
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: doc['urlImage'] == null
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.h),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            color: ColorManger.backGroundColorToSplashScreen
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.h),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: GestureDetector(
                                  onTap: () => openFile(
                                          url: doc['url'],
                                          fileName: doc['name'])
                                      .toString(),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            ColorManger.white.withOpacity(0.5),
                                        radius: 30.h,
                                        child: Text(
                                            doc['fileExtention'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.black)),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            doc['name'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManger.darkGray),
                            color: ColorManger.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(children: [
                          Text(S.of(context).Comments),
                          Text("${doc['comment']}")
                        ]),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.h),
                        width:
                            double.infinity, // Set width to full screen width
                        decoration: BoxDecoration(
                          color: ColorManger.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: GestureDetector(
                            onTap: () => navigateToFullScreenImage(
                                context, doc['urlImage'].toString()),
                            child: Image.network(
                              doc['urlImage'],
                              fit: BoxFit
                                  .cover, // Adjust the fit property as needed
                              width: double
                                  .infinity, // Set width to full screen width
                              height: MediaQuery.of(context).size.height * 0.30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManger.darkGray),
                            color: ColorManger.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(children: [
                          Text(S.of(context).Comments),
                          Text("${doc['comment']}")
                        ]),
                      )
                    ],
                  )));
  }
}

Future<File?> openFile({required String url, String? fileName}) async {
  await downloadFile(url, fileName);

  final file = await downloadFile(url, fileName);
  if (file == null) {
    return null;
  }
  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String? fileName) async {
  try {
    final AppStorage = await getApplicationCacheDirectory();
    final file = File("${AppStorage.path}/$fileName");
    final response = await Dio().get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration.zero,
        ));
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  } on Exception catch (e) {
    e.toString();
  }
}

void navigateToFullScreenImage(BuildContext context, dynamic imageUrl) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => FullScreenImage(imageUrl: imageUrl),
  ));
}

class FullScreenImage extends StatelessWidget {
  final dynamic imageUrl;

  const FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Image.network(
            imageUrl.toString(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}


// void navigateToFullScreenImage(
//     BuildContext context, List<String> imageUrls, int initialIndex) {
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => FullScreenImage(imageUrls: imageUrls, initialIndex: initialIndex),
//   ));
// }
// class FullScreenImage extends StatelessWidget {
//   final List<String> imageUrls;
//   final int initialIndex;

//   const FullScreenImage({required this.imageUrls, required this.initialIndex});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PhotoViewGallery.builder(
//         itemCount: imageUrls.length,
//         builder: (context, index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: NetworkImage(imageUrls[index]),
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 2,
//           );
//         },
//         scrollPhysics: BouncingScrollPhysics(),
//         backgroundDecoration: BoxDecoration(
//           color: Colors.black,
//         ),
//         pageController: PageController(initialPage: initialIndex),
//       ),
//     );
//   }
// }
