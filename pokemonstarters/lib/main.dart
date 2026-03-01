import 'package:flutter/material.dart';

void main() {
  runApp(PokemonStarterApp());
}

class PokemonStarterApp extends StatelessWidget {
  const PokemonStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: PokemonStarterScreen(),
    );
  }
}

class PokemonStarterScreen extends StatefulWidget {
  const PokemonStarterScreen({super.key});

  @override
  State<PokemonStarterScreen> createState() => _PokemonStarterScreenState();
}

class _PokemonStarterScreenState extends State<PokemonStarterScreen> {
  Pokemon pokemonSelected = starters.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PokeHeader("Escolha seu pokémon inicial"),
          PokeCard(pokemon: pokemonSelected),
          PokeOptionList(
            pokemons: starters,
            pokemonSelected: pokemonSelected,
            onSelected: (pokemon) {
              setState(() {
                pokemonSelected = pokemon;
              });
            },
          ),
        ],
      ),
    );
  }
}

class PokeHeader extends StatelessWidget {
  const PokeHeader(this.label, {super.key, this.subTitle});

  final String label;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class Pokemon {
  //final é IMUTAVEL e precisa de construtor
  final String name;
  final String image;

  Pokemon({required this.name, required this.image});
  //Pokemon(this.name, this.image);
}

final starters = [
  Pokemon(name: "Bulbassaur", image: "images/bulbassaur.png"),
  Pokemon(name: "Charmander", image: "images/charmander.png"),
  Pokemon(name: "Squirtle", image: "images/squirtle.png"),
];

class PokeCard extends StatelessWidget {
  const PokeCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(pokemon.image, width: 250, height: 250),
        SizedBox(height: 8),
        Text(
          pokemon.name.toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class PokeOption extends StatelessWidget {
  final Pokemon pokemon;
  final bool selected;
  final Function(Pokemon) onSelected;

  const PokeOption({
    super.key,
    required this.pokemon,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(pokemon),
      child: Column(
        children: [
          Image.asset(
            selected
                ? "images/pokeball_selected.png"
                : "images/pokeball_unselected.png",
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 4),
          Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class PokeOptionList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final Pokemon pokemonSelected;
  final Function(Pokemon) onSelected;

  const PokeOptionList({
    super.key,
    required this.pokemons,
    required this.pokemonSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pokemons.map((pokemon) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: PokeOption(
            pokemon: pokemon,
            selected: pokemon == pokemonSelected,
            onSelected: onSelected,
          ),
        );
      }).toList(),
    );
  }
}