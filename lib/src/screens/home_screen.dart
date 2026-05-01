import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';
import 'package:pet_shop/src/screens/auth_screen.dart';
import 'package:pet_shop/src/widgets/home_screen_tabs/home_screen_home_tab.dart';
import 'package:pet_shop/src/widgets/home_screen_tabs/home_screen_notification_tab.dart';
import 'package:pet_shop/src/widgets/home_screen_tabs/home_screen_user_tab.dart';
import 'package:pet_shop/src/widgets/mode_toggle.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen({super.key, required this.index});
  static MaterialPageRoute route({required int index}) =>
      MaterialPageRoute(builder: (context) => HomeScreen(index: index));
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _color = WidgetColorGenerator();
  int? _selectedTab;

  void _handleSelectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  final List<Widget> _tabList = [
    HomeScreenHomeTab(),
    HomeScreenNotificationTab(),
    HomeScreenUserTab(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedTab = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [Text("Daftar Peliharaan"), ModeToggle()],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: _color.getPrimaryColor(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).push(AuthScreen.route());
          }
        },
        builder: (context, state) {
          return _tabList[_selectedTab!];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab!,
        onTap: _handleSelectTab,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedTab == 0 ? Colors.yellow : null,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LucideIcons.bell,
              color: _selectedTab == 1 ? Colors.yellow : null,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LucideIcons.user,
              color: _selectedTab == 2 ? Colors.yellow : null,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
