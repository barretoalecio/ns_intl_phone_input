import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../ns_intl_phone_input.dart';

class IntlTextEditingController extends TextEditingController {
  IntlTextEditingController({String? text}) : super(text: text);

  CountryModel? selectedCountry;

  MaskTextInputFormatter? maskFormatter;

  void updateText(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void initialPhone({
    required String phoneNumber,
    required String intlDialCode,
  }) {
    selectedCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode: intlDialCode,
          phoneNumber: NSIntlPhoneHelper.getUnMaskedPhoneNumber(
            phoneNumber: phoneNumber,
          ),
        ) ??
        selectedCountry;

    maskFormatter = MaskTextInputFormatter(
      mask: selectedCountry?.format ?? '...-..-....',
      filter: {'.': RegExp(r'[0-9]')},
    );

    updateText(maskFormatter!.maskText(phoneNumber));

    notifyListeners();
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter = MaskTextInputFormatter(
      mask: selectedCountry?.format ?? '...-..-....',
      filter: {'.': RegExp(r'[0-9]')},
    );

    updateText(maskFormatter!.maskText(newCountry?.currentAreaCode ?? ''));

    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    selectedCountry = null;
    maskFormatter = null;
    updateText('');
    notifyListeners();
  }
}
