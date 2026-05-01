import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/cubits/theme/theme_cubit.dart';
import 'package:pet_shop/src/lib/cubits/theme/theme_state.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final _colors = WidgetColorGenerator();

  @override
  Widget build(BuildContext context) {
    void handleButton() {
      context.read<AuthCubit>().logout();
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: state is AuthLoading ? null : handleButton,
                child: Row(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    Icon(
                      LucideIcons.logOut,
                      color: _colors.getButtonText(state: themeState),
                    ),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: _colors.getButtonText(state: themeState),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
