import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:provider/provider.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCard createState() => _CreditCard();
}

class _CreditCard extends State<CreditCard> {
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<BasketPageProvider>(
        builder: (context, pvd, child) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: pvd.cardNumber,
                  expiryDate: pvd.expiryDate,
                  cardHolderName: pvd.cardHolderName,
                  cvvCode: pvd.cvvCode,
                  showBackView: pvd.isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.black,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: pvd.cardNumber,
                          cvvCode: pvd.cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: pvd.cardHolderName,
                          expiryDate: pvd.expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.grey,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: borderBox(),
                            enabledBorder: borderBox(),
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: borderBox(),
                            enabledBorder: borderBox(),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: borderBox(),
                            enabledBorder: borderBox(),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: borderBox(),
                            enabledBorder: borderBox(),
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: pvd.onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonAccept(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              pvd.onClickAddCreditCard(context);
                            } else {
                              print('not valid!');
                            }
                          },
                          text: 'ตกลง',
                          fontSize: 21,
                          fontColor: Colors.white,
                          backgroundColor: Color(0xFFFEBC18),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          fontStyleRegular: false,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder borderBox() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
  }
}
