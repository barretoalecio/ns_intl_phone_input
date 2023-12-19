import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map_impl.dart';
import 'package:ns_intl_phone_input/src/presentation/widgets/country_dropdown_widget.dart';

import '../data/models/country.dart';
import '../raw/raw_countries.dart';

class CountrySelectScreen extends StatefulWidget {
  const CountrySelectScreen({
    super.key,
    required this.onCountrySelected,
  });

  final Function(CountryModel) onCountrySelected;

  @override
  State<CountrySelectScreen> createState() => _CountrySelectScreenState();
}

class _CountrySelectScreenState extends State<CountrySelectScreen> {
  final _countriesLookupMap = ConstructLookupMapImpl()(rawCountries);

  late final List<CountryModel> countries;

  List<CountryModel> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countries = _countriesLookupMap.entries
        .map((e) => e.value)
        .toList()
        .cast<CountryModel>();

    filteredCountries = countries;
  }

  void filterCountries() {
    List<CountryModel> tempCountries = [];
    tempCountries.addAll(countries);
    if (searchController.text.isNotEmpty) {
      tempCountries
          .retainWhere((country) => country.isContain(searchController.text));
    }
    setState(() {
      filteredCountries = tempCountries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterCountries();
              },
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: CountryDropDownWidget(
                    country: filteredCountries[index],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onCountrySelected(filteredCountries[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
