import 'package:client/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key})
    : super(
        title: const Text(AppConstants.appName),
        backgroundColor: Colors.greenAccent[400],
        foregroundColor: Colors.white,
        elevation: 50.0,

        // TODO placeholder icons, to be replaced with actual functionality later
        actions: <Widget>[
          
          //IconButton
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ), 
          
          //IconButton
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), 
        ], 
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
