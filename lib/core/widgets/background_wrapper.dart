import 'package:flutter/material.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';

/// Reusable background wrapper for all screens.
class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({
    super.key,
    required this.child,
    required this.themeProvider,
  });
  final ThemeProvider themeProvider;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: themeProvider.getIsDarkTheme
              ? AssetImage('assets/images/background_darkmode.png')
              : AssetImage('assets/images/bachground_lightmode.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
