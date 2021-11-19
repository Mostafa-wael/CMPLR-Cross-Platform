// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars

import 'dart:math';

Random random = Random();
List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List posts = List.generate(
    13,
    (index) => {
          "name": names[random.nextInt(10)],
          "dp": "../../utilities/assets/logo/trans_logo.png",
          "time": "${random.nextInt(50)} min ago",
          "img": "../../utilities/assets/logo/logo_icon.png"
        });

List types = ["text", "image"];
