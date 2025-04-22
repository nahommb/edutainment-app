import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Colors.transparent,leading: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.primary,)),) ;
  }
}
