// import 'package:eyehelper/src/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class ListPrefsSlideAction extends ClosableSlideAction {
//   final Color? foregroundColor;
//   final Function? onEdit;
//   final Function? onDelete;

//   const ListPrefsSlideAction({
//     Key? key,
//     this.foregroundColor,
//     Color? color,
//     VoidCallback? onTap,
//     this.onEdit,
//     this.onDelete,
//     bool closeOnTap = true,
//   }) : super(
//           key: key,
//           color: Colors.transparent,
//           onTap: onTap,
//           closeOnTap: closeOnTap,
//         );

//   @override
//   Widget buildAction(BuildContext context) {
//     final Color estimatedColor = ThemeData.estimateBrightnessForColor(color) == Brightness.light
//         ? Colors.black
//         : Colors.white;

//     return Padding(
//       padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 12),
//       child: Container(
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0, right: 4.0),
//                 child: InkWell(
//                   onTap: () {
//                     Slidable.of(context)?.close();
//                     onEdit?.call();
//                   },
//                   child: AspectRatio(
//                     aspectRatio: 1.0,
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: 20),
//                       decoration: BoxDecoration(
//                           color: EyehelperColorScheme.warningColor,
//                           borderRadius: BorderRadius.circular(16.0)),
//                       child: Center(
//                         child: new Icon(
//                           Icons.edit,
//                           size: 40.0,
//                           color: foregroundColor ?? estimatedColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 8.0, right: 16.0),
//                 child: InkWell(
//                   onTap: () {
//                     Slidable.of(context).close();
//                     onDelete?.call();
//                   },
//                   child: AspectRatio(
//                     aspectRatio: 1.0,
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: 20),
//                       decoration: BoxDecoration(
//                           color: EyehelperColorScheme.errorColor,
//                           borderRadius: BorderRadius.circular(16.0)),
//                       child: Center(
//                         child: new Icon(
//                           Icons.delete,
//                           size: 40.0,
//                           color: foregroundColor ?? estimatedColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
