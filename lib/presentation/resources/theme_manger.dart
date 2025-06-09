import 'package:flutter/material.dart';
import 'package:newtest/presentation/resources/color_manger.dart';
import 'package:newtest/presentation/resources/font_manger.dart';
import 'package:newtest/presentation/resources/styles_manger.dart';
import 'package:newtest/presentation/resources/values_manger.dart';

ThemeData getAppLicationTheme() {
  return ThemeData(
    //main color
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,//ripple effect

    //cardview theme 
    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
    ),

    //AppBar theme 
    appBarTheme: AppBarTheme(
    backgroundColor: ColorManger.white,
    elevation: AppSize.s0,
    shadowColor:  ColorManger.lightPrimary,
    titleTextStyle: getRegularStyle(color: ColorManger.white,fontSize: FontSize.s16)
    ),

    //button theme 
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),

    //elevetd button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: getRegularStyle(color: ColorManger.white,fontSize: FontSize.s16),
      //primary : ColorManger.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12)
      )
    )
    ),

    //text theme
    textTheme: TextTheme(
      headlineLarge : getBoldStyle(color: ColorManger.darkGrey,fontSize: FontSize.s16),
      headlineMedium: getLightStyle(color: ColorManger.lightGrey,fontSize: FontSize.s14),
      headlineSmall: getRegularStyle(color: ColorManger.grey1),
      bodyMedium: getRegularStyle(color: ColorManger.grey),
      displayLarge: getLightStyle(color: ColorManger.white,fontSize: FontSize.s22),
    ),
    //input decoration theme

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManger.grey,fontSize: FontSize.s14),
        labelStyle: getMediumStyle(color: ColorManger.grey,fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManger.error,fontSize: FontSize.s14),
       //enable border style
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),

        ),

        //focused border style
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(
          color: ColorManger.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),

        ),
        //error border style
        errorBorder: OutlineInputBorder(borderSide: BorderSide(
          color: ColorManger.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),

        ),

        //focused error border style
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),

        ),

    )
  );
}
