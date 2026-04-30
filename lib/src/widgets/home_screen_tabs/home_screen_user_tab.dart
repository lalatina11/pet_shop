import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/repository/auth_remote_repository.dart';
import 'package:pet_shop/src/models/user_model.dart';
import 'package:pet_shop/src/widgets/auth_form/logout_button.dart';
import 'package:pet_shop/src/widgets/home_screen_tabs/user_skeleton.dart';

class HomeScreenUserTab extends StatefulWidget {
  const HomeScreenUserTab({super.key});

  @override
  State<HomeScreenUserTab> createState() => _HomeScreenUserTabState();
}

class _HomeScreenUserTabState extends State<HomeScreenUserTab> {
  final authRemote = AuthRemoteRepository();
  UserModel? user;
  bool loading = false;

  void getUser() async {
    try {
      setState(() {
        loading = true;
      });
      final res = await authRemote.getUserData();
      print(res);
      if (res.success) {
        final data = res.data as Map<String, dynamic>;
        final result = UserModel(
          email: data['email'],
          id: data['id'],
          name: data['name'],
          image: data['image'],
        );
        setState(() {
          user = result;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading
            ? UserSkeleton()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  spacing: 20,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.network(
                        "https://imgs.search.brave.com/55nMliVtPWXUSJ8kAiH34dARMoOhS1iHyeUYoMo93tE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9mbHV0/dGVyLmdpdGh1Yi5p/by9hc3NldHMtZm9y/LWFwaS1kb2NzL2Fz/c2V0cy93aWRnZXRz/L293bC5qcGc",
                        fit: .cover,
                        width: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .start,
                      children: [
                        Text(
                          user!.name,
                          style: TextStyle(fontSize: 20, fontWeight: .bold),
                        ),
                        Text(user!.email, style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
        LogoutButton(),
      ],
    );
  }
}
