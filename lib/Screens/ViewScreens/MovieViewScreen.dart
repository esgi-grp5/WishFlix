import 'package:flutter/material.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/Widgets/DisplayItem/ImageTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowInformationsWithTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowWishListInfo.dart';

double? width;
double? height;

class MovieViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    debugPrint('--------- height : ' + height.toString());
    debugPrint('--------- width : ' + width.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: rootPage.appTheme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'MOVIE',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ImageTitle(
                title: "Fast and furious",
                subTitle1: "2h23",
                subTitle2: "Action, Course",
                imageAssetUrl: "assets/images/Kerman.png"),
            RowWishListInfo(dateSortie: "26 juillet 2014", estVuText: "Non vu"),
            RowInformationsWithTitle(
              informationTitle: "Synopsis",
              informationContent:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac facilisis ligula, sit amet lacinia erat. Suspendisse vel sagittis elit. Praesent suscipit nisl sit amet eros feugiat finibus. Nullam suscipit enim eleifend lorem rutrum, vel tempor enim faucibus. Vestibulum vitae facilisis lacus, eu ultrices felis. In scelerisque risus vitae justo convallis cursus. Maecenas ultrices eget tellus nec fermentum. Donec porttitor, leo sagittis aliquet efficitur, urna libero aliquam nibh, ut egestas justo lorem vitae nisi. Integer sed ornare lorem. Integer ornare augue eget erat aliquam hendrerit. Nulla consequat enim sit amet risus gravida, nec rutrum libero tincidunt. Ut non massa sed enim dictum volutpat. In diam justo, convallis vitae commodo vitae, pulvinar at nisl. Fusce ultricies non dolor at malesuada. \n Etiam gravida eleifend interdum. Integer et finibus mauris. Curabitur dapibus lacinia tincidunt. Nam ut quam at eros ultrices sodales. Suspendisse pellentesque ullamcorper pulvinar. Sed sed nisl enim. Pellentesque placerat ullamcorper velit sed tempus. Proin dictum volutpat fermentum. Aliquam erat volutpat. Suspendisse sollicitudin, tellus id luctus consectetur, est nulla iaculis ex, condimentum euismod dolor nulla sit amet lacus. Praesent placerat non velit ut dignissim. Maecenas porttitor sollicitudin turpis. Integer finibus eros eget velit aliquet, et consequat sapien posuere.",
            ),
          ],
        ),
      ),
    );
  }
}

// createImageTitle(titleText, subTitleText1, subTitleText2, imageAssetUrl) {
//   return Row(children: <Widget>[
//     Container(
//       width: width,
//       height: height! * .24 < 220 ? height! * .24 : 220,
//       decoration: BoxDecoration(
//           image: DecorationImage(
//         image: AssetImage(imageAssetUrl),
//         fit: BoxFit.cover,
//         alignment: Alignment.center,
//       )),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             height: 120,
//             width: width,
//             left: 0,
//             //right: 0,
//             bottom: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                 Colors.black.withOpacity(1),
//                 Colors.black.withOpacity(0.00)
//               ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
//             ),
//           ),
//           Positioned(
//             bottom: 45,
//             left: 10,
//             child: Text(
//               titleText,
//               style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white),
//             ),
//           ),
//           Positioned(
//             bottom: 25,
//             left: 14,
//             child: Text(
//               subTitleText1 + " • " + subTitleText2,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white),
//             ),
//           )
//         ],
//       ),
//     )
//   ]);
// }

// createRowWishListInfo(dateSortie, estVuText) {
//   return Row(
//     children: [
//       Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(0),
//           width: width,
//           height: height! * .07 < 60 ? height! * .07 : 60,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 14),
//                         child: Icon(Icons.calendar_month, color: Colors.black),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 5, right: 14),
//                         child: Text(
//                           dateSortie,
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 14),
//                         child: Icon(Icons.remove_red_eye_outlined,
//                             color: Colors.black),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 5, right: 14),
//                         child: Text(
//                           estVuText,
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     ],
//   );
// }

// createRowInformations(informationTitle, informationContent, note) {
//   return Row(
//     children: [
//       Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(0),
//           width: width,
//           height: height! * .2 < 190 ? height! * .2 : 190,
//           child: Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Column(mainAxisSize: MainAxisSize.max, children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(
//                     informationTitle,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 flex: 1,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical, //.horizontal
//                   child: Text(
//                     informationContent,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ]),
//           )),
//     ],
//   );
// }
