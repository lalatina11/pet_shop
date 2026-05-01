import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop/src/lib/config/env_config.dart';
import 'package:pet_shop/src/models/pet_model.dart';
import 'package:pet_shop/src/widgets/home_screen_tabs/pet_skeleton.dart';
import 'package:pet_shop/src/widgets/pet/pet_card.dart';

class HomeScreenHomeTab extends StatefulWidget {
  const HomeScreenHomeTab({super.key});

  @override
  State<HomeScreenHomeTab> createState() => _HomeScreenHomeTabState();
}

class _HomeScreenHomeTabState extends State<HomeScreenHomeTab> {
  final env = EnvConfig();
  List<PetModel> pets = [];
  bool isLoading = false;
  String errorMessage = "";

  void fetchPets() async {
    try {
      isLoading = true;
      final res = await http.get(env.getUriFromApiBaseURL(path: "/pets"));
      final result = jsonDecode(res.body);
      if (result['success']) {
        final list = result['data'] as List<dynamic>;
        final petlist = list
            .map((e) => PetModel.fromMap(e as Map<String, dynamic>))
            .toList();
        setState(() {
          pets = petlist;
        });
      }
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return PetSkeleton();
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (pets.isEmpty) {
      return const Center(child: Text('Tidak ada peliharaan tersedia'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return PetCard(pet: pet);
      },
    );
  }
}
