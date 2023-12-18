import 'package:flutter/widgets.dart';
import 'package:ns_intl_phone_input/src/presentation/widgets/font_text_widget.dart';

import '../../domain/entities/country.dart';

class CountryDropDownWidget extends StatelessWidget {
  const CountryDropDownWidget({
    super.key,
    required this.country,
  });

  final CountryEntity country;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FontTextWidget(text: country.flag),
        const SizedBox(width: 8),
        Text(
          '${country.iso2Code} +${country.dialCode}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          country.countryName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
