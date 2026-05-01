import 'package:flutter/material.dart';
import 'package:pet_shop/src/models/pet_model.dart';
import 'package:pet_shop/src/screens/single_pet_screen.dart';
import 'package:intl/intl.dart';

class PetCard extends StatefulWidget {
  final PetModel pet;
  const PetCard({super.key, required this.pet});

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '\Rp', // Optional: specify symbol explicitly
    decimalDigits: 1,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(SinglePetScreen.route(pet: widget.pet)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: Image.network(widget.pet.image),
              ),
              Container(
                alignment: .centerLeft,
                child: Text(
                  "Jenis: ${widget.pet.type} ${widget.pet.breed}",
                  style: TextStyle(fontSize: 16, fontWeight: .w500),
                ),
              ),

              Container(
                alignment: .centerLeft,
                child: Text(
                  "Gender: ${widget.pet.gender == "MALE" ? "Jantan" : "Betina"}",
                  style: TextStyle(fontSize: 16, fontWeight: .w500),
                ),
              ),
              Container(
                alignment: .centerLeft,
                child: Text(
                  "Harga: ${formatter.format(widget.pet.price)}",
                  style: TextStyle(fontSize: 16, fontWeight: .w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
