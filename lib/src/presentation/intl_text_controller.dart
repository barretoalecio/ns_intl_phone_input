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
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
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
    );

    value = value.copyWith(
      text: maskFormatter.maskText(phoneNumber),
      selection: TextSelection.collapsed(
        offset: maskFormatter.maskText(phoneNumber).length,
      ),
    );
  }

  void updatePhone({
    required String phoneNumber,
  }) {
    selectedCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode: selectedCountry!.dialCode,
          phoneNumber: NSIntlPhoneHelper.getUnMaskedPhoneNumber(
            phoneNumber: phoneNumber,
          ),
        ) ??
        selectedCountry;

    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
    );

    text = maskFormatter.maskText(phoneNumber);
  }

  void setCountry(CountryModel? newCountry) {
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
    );

    text = maskFormatter.maskText(newCountry?.currentAreaCode ?? '');
  }

  @override
  void clear() {
    super.clear();
    selectedCountry = null;
  }
}
