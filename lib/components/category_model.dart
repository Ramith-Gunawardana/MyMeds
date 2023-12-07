import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor = const Color.fromARGB(255, 158, 158, 158);

  bool isSelected;

  CategoryModel({
    required this.name,
    required this.iconPath,
    this.isSelected = false,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Capsule',
        iconPath: 'lib/assets/icons/tablet.gif',
      ),
    );

    categories.add(CategoryModel(
      name: 'Tablet',
      iconPath: 'lib/assets/icons/pills.gif',
    ));

    categories.add(CategoryModel(
      name: 'Liquid',
      iconPath: 'lib/assets/icons/liquid.gif',
    ));

    categories.add(CategoryModel(
      name: 'Topical',
      iconPath: 'lib/assets/icons/tube.gif',
    ));

    categories.add(CategoryModel(
      name: 'Cream',
      iconPath: 'lib/assets/icons/cream.gif',
    ));

    categories.add(CategoryModel(
      name: 'Drops',
      iconPath: 'lib/assets/icons/drops.gif',
    ));

    categories.add(CategoryModel(
      name: 'Foam',
      iconPath: 'lib/assets/icons/foam.gif',
    ));

    categories.add(CategoryModel(
      name: 'Gel',
      iconPath: 'lib/assets/icons/tube.gif',
    ));

    categories.add(CategoryModel(
      name: 'Herbal',
      iconPath: 'lib/assets/icons/herbal.gif',
    ));

    categories.add(CategoryModel(
      name: 'Inhaler',
      iconPath: 'lib/assets/icons/inhalator.gif',
    ));

    categories.add(CategoryModel(
      name: 'Injection',
      iconPath: 'lib/assets/icons/syringe.gif',
    ));

    categories.add(CategoryModel(
      name: 'Lotion',
      iconPath: 'lib/assets/icons/lotion.gif',
    ));

    categories.add(CategoryModel(
      name: 'Nasal Spray',
      iconPath: 'lib/assets/icons/nasalspray.gif',
    ));

    categories.add(CategoryModel(
      name: 'Ointment',
      iconPath: 'lib/assets/icons/tube.gif',
    ));

    categories.add(CategoryModel(
      name: 'Patch',
      iconPath: 'lib/assets/icons/patch.gif',
    ));

    categories.add(CategoryModel(
      name: 'Powder',
      iconPath: 'lib/assets/icons/powder.gif',
    ));

    categories.add(CategoryModel(
      name: 'Spray',
      iconPath: 'lib/assets/icons/spray.gif',
    ));

    categories.add(CategoryModel(
      name: 'Suppository',
      iconPath: 'lib/assets/icons/suppository.gif',
    ));

    return categories;
  }
}

//names: Capsule, Tablet, Liquid, Topical, Cream, Drops, Foam, Gel, Inhaler, Injection, Lotion, Ointment, Patch, Powder, Spray, Suppository.