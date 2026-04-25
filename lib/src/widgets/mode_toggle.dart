import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/theme_cubit.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pet_shop/src/lib/cubits/theme_state.dart';

class ModeToggle extends StatefulWidget {
  const ModeToggle({super.key});

  @override
  State<ModeToggle> createState() => _ModeToggleState();
}

class _ModeToggleState extends State<ModeToggle> {
  void switchTheme() {
    context.read<ThemeCubit>().switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: switchTheme,
            child: Icon(
              state == ThemeState.dark ? LucideIcons.sun : LucideIcons.moon,
            ),
          ),
        );
      },
    );
  }
}
