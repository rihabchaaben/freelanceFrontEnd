import 'package:flutter/material.dart';
import 'colors.dart';

TextStyle signText = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 18.0,
  fontWeight: FontWeight.w800,
  color: Color.fromARGB(255, 3, 3, 3),
);
TextStyle titleStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 18.0,
  fontWeight: FontWeight.w800,
  color: txtColor,
);
TextStyle descriptionStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.0,
  fontWeight: FontWeight.w200,
  color: txtColor,
);
TextStyle textmessageError = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.0,
  fontWeight: FontWeight.w200,
  color: const Color.fromARGB(255, 240, 67, 67),
);
ButtonStyle startBtnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(wlcBtnColor),
  padding:
      MaterialStateProperty.all(const EdgeInsets.only(left: 40, right: 40)),
  elevation: MaterialStateProperty.all(12),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
  // shadowColor:
  //     MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface),
);
TextStyle startBtnTextStyle = const TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
);
BoxDecoration userImg = const BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/ali.jpg'),
    fit: BoxFit.fill,
  ),
  shape: BoxShape.circle,
);
TextStyle categoriesStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 14.0,
  fontWeight: FontWeight.w800,
  color: txtColor,
);
TextStyle recTitlesStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.bold);
TextStyle recSubtitlesStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.normal);

TextStyle trendTitleStyle = TextStyle(
    color: txtColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.bold);
TextStyle trendSubtitleStyle = TextStyle(
    color: txtColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.normal);
