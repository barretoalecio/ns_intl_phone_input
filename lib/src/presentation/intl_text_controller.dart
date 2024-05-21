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

    updateMaskAndText(phoneNumber);
  }

  void setCountry(CountryModel? newCountry) {
    selectedCountry = newCountry;
    updateMaskAndText(newCountry?.currentAreaCode ?? '');
  }

  void updateMaskAndText(String phoneNumber) {
    if (text.isNotEmpty) {
      final unmaskedText = maskFormatter.getUnmaskedText();
      final maskedText =
          maskFormatter.maskText(phoneNumber.substring(unmaskedText.length));
      final newText = unmaskedText + maskedText;
      value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } else {
      maskFormatter = MaskTextInputFormatter(
        mask: selectedCountry?.format ?? '...-..-....',
        filter: {'.': RegExp(r'[0-9]')},
      );
      final maskedText = maskFormatter.maskText(phoneNumber);
      value = TextEditingValue(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    }
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
  }
}
