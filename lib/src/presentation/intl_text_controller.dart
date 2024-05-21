import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../ns_intl_phone_input.dart';

class IntlTextEditingController extends TextEditingController {
  CountryModel? selectedCountry;

  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {'.': RegExp(r'[0-9]')},
  );

  IntlTextEditingController({String? text}) : super(text: text) {
    addListener(_applyMask);
  }

  void _applyMask() {
    final newText = maskFormatter.maskText(text);
    if (newText != text) {
      value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
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
    );

    final newText = maskFormatter.maskText(phoneNumber);

    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
    );

    final newText = maskFormatter.maskText(newCountry?.currentAreaCode ?? '');

    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  void clear() {
    selectedCountry = null;
    super.clear();
  }
}
