import 'package:flutter/material.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';
import 'package:pet_shop/src/models/pet_model.dart';
import 'package:pet_shop/src/widgets/mode_toggle.dart';

class SinglePetScreen extends StatefulWidget {
  final PetModel pet;
  const SinglePetScreen({super.key, required this.pet});

  static MaterialPageRoute route({required PetModel pet}) =>
      MaterialPageRoute(builder: (context) => SinglePetScreen(pet: pet));

  @override
  State<SinglePetScreen> createState() => _SinglePetScreenState();
}

class _SinglePetScreenState extends State<SinglePetScreen> {
  final _color = WidgetColorGenerator();

  @override
  Widget build(BuildContext context) {
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
      body: Card(
        child: Text(
          widget.pet.id,
          style: TextStyle(fontSize: 30, fontWeight: .bold),
        ),
      ),
    );
  }
}
