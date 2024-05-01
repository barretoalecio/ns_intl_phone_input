import 'package:flutter/material.dart';

import '../data/models/country.dart';
import 'country_selection_widget.dart';

class CountrySelectScreen extends StatelessWidget {
  const CountrySelectScreen({
    super.key,
    required this.onCountrySelected,
    required this.title,
    required this.countrySelectionLabel,
    required this.titleStyle,
  });

  final Function(CountryModel) onCountrySelected;
  final String title;
  final TextStyle titleStyle;
  final String countrySelectionLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: titleStyle,
        ),
      ),
      body: CountrySelectionWidget(
        countrySelectionLabel: countrySelectionLabel,
        onCountrySelected: (country) {
          onCountrySelected(country);
          Navigator.of(context).pop(country);
        },
      ),
    );
  }
}
