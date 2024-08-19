import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustumButtonWeb extends StatelessWidget {
  final String buttonTitle;
  final String iconName;
  final screen;
  const CustumButtonWeb({
    super.key,
    required this.buttonTitle,
    required this.iconName,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 10,
    //   child: Container(
    //     alignment: Alignment.center,
    //     height: MediaQuery.of(context).size.height * .17,
    //     child: ListTile(
    //       onTap: () {
    //         Navigator.push(
    //             context, MaterialPageRoute(builder: (context) => screen));
    //       },
    //       title: Text(
    //         buttonTitle,
    //         style: TextStyle(fontSize: 30),
    //       ),
    //       trailing: Lottie.asset("assets/lottie_icons/$iconName",
    //           fit: BoxFit.cover, width: 120),
    //       // leading: Lottie.asset("assets/lottie_icons/$iconName",
    //       //     height: 200, width: 200),
    //       mouseCursor: MouseCursor.uncontrolled,
    //       hoverColor: Colors.deepOrange,
    //     ),
    //   ),
    // );
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Card(
        child: Container(
          child: Column(
            children: [
              Lottie.asset("assets/lottie_icons/$iconName", height: 130),
              Text(
                buttonTitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Card(
//   child: Container(
//     child: Column(
//       children: [
//         Lottie.asset("assets/lottie_icons/$iconName", height: 130),
//         Text(
//           buttonTitle,
//           textAlign: TextAlign.center,
//         ),
//       ],
//     ),
//   ),
// ),
