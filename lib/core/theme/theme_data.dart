import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primary,
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(AppColors.lightBackground), // Background of the switch
        thumbColor: MaterialStateProperty.all(AppColors.primary),
        trackOutlineColor: MaterialStateProperty.all(AppColors.primary),
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: AppColors.primary,
                width: 0.9
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Colors.black,
                width: 0.9
            )
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,

              textStyle: TextStyle(fontWeight:FontWeight.bold ,color:AppColors.lightBackground),
              shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(10)
              )
          )
      ),
  );
  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.5
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.5
              )
          ),
          // contentPadding:EdgeInsets.all(25)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              textStyle: TextStyle(fontWeight:FontWeight.bold ),
              shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(10)
              )
          )
      )
  );
}