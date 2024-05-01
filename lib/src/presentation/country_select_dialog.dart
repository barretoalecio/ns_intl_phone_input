import 'package:flutter/material.dart';

import '../data/models/country.dart';
import 'country_selection_widget.dart';

void countrySelectDialog(
  BuildContext context, {
  required Function(CountryModel) onCountrySelected,
  required String titleText,
  required TextStyle titleStyle,
  required String countrySelectionLabel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: CountrySelectionDialogWidget(
          onCountrySelected: onCountrySelected,
          title: titleText,
          titleStyle: titleStyle,
          countrySelectionLabel: countrySelectionLabel,
        ),
      );
    },
  );
}

class CountrySelectionDialogWidget extends StatelessWidget {
  const CountrySelectionDialogWidget({
    super.key,
    required this.onCountrySelected,
    required this.title,
    required this.titleStyle,
    required this.countrySelectionLabel,
  });

  final Function(CountryModel) onCountrySelected;
  final String title;
  final TextStyle? titleStyle;
  final String countrySelectionLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(height: 8),
          Flexible(
            child: CountrySelectionWidget(
              onCountrySelected: (country) {
                onCountrySelected(country);
                Navigator.of(context).pop(country);
              },
              countrySelectionLabel: countrySelectionLabel,
            ),
          ),
        ],
      ),
    );
  }
}
