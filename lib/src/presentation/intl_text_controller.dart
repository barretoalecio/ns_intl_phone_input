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

    // Atualiza a máscara com o formato do país selecionado
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
      // Define o novo valor do campo de texto sem aplicar a máscara
      newValue: TextEditingValue(text: phoneNumber),
    );

    // Aplica a máscara ao número de telefone e define o valor do campo
    text = maskFormatter.maskText(phoneNumber);
    notifyListeners();
  }

  void setCountry(CountryModel? newCountry) {
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {'.': RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: selectedCountry?.currentAreaCode ?? ''),
    );

    text = maskFormatter.maskText(newCountry?.currentAreaCode ?? '');

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
