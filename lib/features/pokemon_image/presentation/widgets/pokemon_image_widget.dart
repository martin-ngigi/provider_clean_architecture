import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_clean_architecture/features/pokemon_image/business/entities/pokemon_image_entity.dart';
import 'package:provider_clean_architecture/features/pokemon_image/presentation/providers/pokemon_image_provider.dart';

import '../../../../../core/errors/failure.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {

    /// We will have either pokemonImageEntity or failure. So that's why they are nullable.
    PokemonImageEntity? pokemonImageEntity = Provider.of<PokemonImageProvider>(context).pokemonImage;
    Failure? failure = Provider.of<PokemonImageProvider>(context).failure;

    late Widget widget;
    if(pokemonImageEntity != null){
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: DecorationImage(
              // image: AssetImage('assets/images/mapp.png'),
              image: FileImage(File(pokemonImageEntity.path)),
            ),
          ),
          child: child,
        ),
      );
    }
    else if(failure != null){
      widget = Expanded(
          child: Center(
            child: Text(
              failure.errorMessage,
              style: TextStyle(
                fontSize: 22
              ),
            ),
          )
      );
    }
    else {
      widget = const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          )
      );
    }
    return widget;
  }
}
