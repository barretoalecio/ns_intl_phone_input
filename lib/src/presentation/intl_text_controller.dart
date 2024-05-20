import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../ns_intl_phone_input.dart';

class IntlTextEditingController extends TextEditingController {
  IntlTextEditingController({String? text}) : super(text: text);

  CountryModel? selectedCountry;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {'.': RegExp(r'[0-9]')},
  );

  @override
  set text(String newText) {
    super.text = newText;
    notifyListeners();
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

    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: selectedCountry?.currentAreaCode ?? ''),
    );

    value = TextEditingValue(
      text: maskFormatter.maskText(phoneNumber),
      selection: TextSelection.collapsed(offset: text.length),
    );

    notifyListeners();
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: selectedCountry?.currentAreaCode ?? ''),
    );

    value = TextEditingValue(
      text: maskFormatter.maskText(newCountry?.currentAreaCode ?? ''),
      selection: TextSelection.collapsed(offset: text.length),
    );

    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    selectedCountry = null;
    text = '';
    notifyListeners();
  }
}
