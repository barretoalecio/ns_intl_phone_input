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

    final maskedText = maskFormatter.maskText(phoneNumber);
    value = TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
    );

    final maskedText =
        maskFormatter.maskText(newCountry?.currentAreaCode ?? '');
    value = TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
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
