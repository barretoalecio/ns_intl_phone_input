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
    );

    final newText = maskFormatter.maskText(phoneNumber);

    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );

    notifyListeners();
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
    );

    final newText = maskFormatter.maskText(newCountry?.currentAreaCode ?? '');

    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );

    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    selectedCountry = null;
    value = const TextEditingValue(
      text: '',
      selection: TextSelection.collapsed(offset: 0),
    );
    notifyListeners();
  }
}
