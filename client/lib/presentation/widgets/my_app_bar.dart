import 'package:client/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppConstants.appName),
      backgroundColor: Colors.greenAccent[400],
      foregroundColor: Colors.white,
      elevation: 50.0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      
      actions: <Widget>[
        // Button to change the language, using a PopupMenuButton to show the options
        _buildLanguagePopupMenuButton(context),
      ], 
    );
  }

  PopupMenuButton<Locale> _buildLanguagePopupMenuButton(BuildContext context) {
    return PopupMenuButton<Locale>(
        icon: const Icon(Icons.language), // Ícone de globo/linguagem
        tooltip: 'change_language'.tr(context: context),
        // Esta função é chamada quando o utilizador escolhe uma opção
        onSelected: (Locale newLocale) {
          context.setLocale(newLocale); // O EasyLocalization muda o idioma aqui!
        },
        
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
          const PopupMenuItem<Locale>(
            value: Locale('en'),
            child: Text('English'),
          ),
          const PopupMenuItem<Locale>(
            value: Locale('pt'),
            child: Text('Português'),
          ),
        ],
      );
  }



  // Isto é obrigatório quando implementas a PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}