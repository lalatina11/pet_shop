import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/config/env_config.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';
import 'package:pet_shop/src/models/pet_model.dart';
import 'package:pet_shop/src/widgets/mode_toggle.dart';
import "package:http/http.dart" as http;
import 'package:pet_shop/src/widgets/pet/pet_card.dart';

class SinglePetScreen extends StatefulWidget {
  final PetModel pet;
  const SinglePetScreen({super.key, required this.pet});

  static MaterialPageRoute route({required PetModel pet}) =>
      MaterialPageRoute(builder: (context) => SinglePetScreen(pet: pet));

  @override
  State<SinglePetScreen> createState() => _SinglePetScreenState();
}

class _SinglePetScreenState extends State<SinglePetScreen> {
  final envConfig = EnvConfig();
  final _color = WidgetColorGenerator();
  PetModel? pet;
  bool isLoading = false;

  void petFetch() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.get(
        envConfig.getUriFromApiBaseURL(path: "/pets/${widget.pet.id}"),
      );
      final result = jsonDecode(res.body);
      if (result['success']) {
        final data = result['data'] as Map<String, dynamic>;
        final petResult = PetModel.fromMap(data);
        setState(() {
          pet = petResult;
        });
      }
    } catch (e) {
      print(e);
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
    petFetch();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("${widget.pet.type} ${widget.pet.breed}"),
              ModeToggle(),
            ],
          ),
          backgroundColor: _color.getPrimaryColor(),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (pet == null) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("${widget.pet.type} ${widget.pet.breed}"),
              ModeToggle(),
            ],
          ),
          backgroundColor: _color.getPrimaryColor(),
        ),
        body: Center(child: Text("An error occured")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text("${widget.pet.type} ${widget.pet.breed}"),
            ModeToggle(),
          ],
        ),
        backgroundColor: _color.getPrimaryColor(),
      ),
      body: Column(
        children: [
          PetCard(pet: pet!),
          Container(
            alignment: .centerStart,
            width: .infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Nama: ${pet!.name}"),
                    Text("Deskripsi: ${pet!.description}"),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: .center,
            spacing: 20,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Checkout")),
              ElevatedButton(onPressed: () {}, child: Text("+ Keranjang")),
            ],
          ),
        ],
      ),
    );
  }
}
