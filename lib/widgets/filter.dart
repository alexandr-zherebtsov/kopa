import 'package:flutter/material.dart';
import 'package:kopa/models/add_ads_model.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:toast/toast.dart';

class BottomFilter extends StatefulWidget {
  @override
  _BottomFilterState createState() => _BottomFilterState();
}

class _BottomFilterState extends State<BottomFilter> {

  String adsPrice, adsBrand, adsSizeS, adsSizeF, adsLength, adsWidth, adsMaterial, adsDescription;
  String _sizesValueS, _sizesValueF, _brandValue, _materialValue;

  final _textPriceS = TextEditingController();
  final _textPriceF = TextEditingController();

  bool _validateBrand = false;
  bool _validateMaterial = false;
  bool _validateSizeS = false;
  bool _validateSizeF = false;
  bool _validatePriceS = false;
  bool _validatePriceF = false;
  bool _validatePriceSSumb = false;
  bool _validatePriceFSumb = false;

  Widget _titleText(String titleText) {
    return Padding(
      padding: const EdgeInsets.only(top: 17.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              color: brightTurquoise,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(width: 7),
          Text(titleText, style: mediumWhiteText),
        ],
      ),
    );
  }

  Widget _textFields(controller, validateS, validateF, hintText) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: brightTurquoise,
      maxLength: 4,
      decoration: InputDecoration(
        counter: Offstage(),
        hintText: hintText,
        errorText: validateS ? 'Вкажіть ціну' : validateF ? 'Перевірте ціну' : null,
        errorStyle: smallErrorText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lightGrayText),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: brightTurquoise),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: brightTurquoise),
        ),
      ),
      onChanged: (val) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 24.0, top: 2.0, left: 17.0, right: 17.0),
        decoration: BoxDecoration(
          color: grayBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            IconButton(
              icon: Icon(Icons.keyboard_arrow_down, color: whiteColor),
              iconSize: 32,
              tooltip: 'Закрити',
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            _titleText('Модель'),
            DropdownButton(
              hint: Text('Оберіть модель'),
              value: _brandValue,
              iconEnabledColor: _validateBrand ? errorColor : brightTurquoise,
              isExpanded: true,
              items: brandList.map((val) {
                return DropdownMenuItem(
                  child: Text(val),
                  value: val,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _brandValue = val;
                  adsBrand = val;
                });
              },
            ),

            _titleText('Матеріал'),
            DropdownButton(
              hint: Text('Оберіть матеріал'),
              value: _materialValue,
              iconEnabledColor: _validateMaterial ? errorColor : brightTurquoise,
              isExpanded: true,
              items: materialList.map((val) {
                return DropdownMenuItem(
                  child: Text(val),
                  value: val,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _materialValue = val;
                  adsMaterial = val;
                });
              },
            ),

            _titleText('Розмір'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 98,
                  child: DropdownButton(
                    hint: Text('Від'),
                    value: _sizesValueS,
                    iconEnabledColor: _validateSizeS ? errorColor : brightTurquoise,
                    isExpanded: true,
                    items: sizesList.map((val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _sizesValueS = val;
                        adsSizeS = val;
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 98,
                  child: DropdownButton(
                    hint: Text('До'),
                    value: _sizesValueF,
                    iconEnabledColor: _validateSizeF ? errorColor : brightTurquoise,
                    isExpanded: true,
                    items: sizesList.map((val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _sizesValueF = val;
                        adsSizeF = val;
                      });
                    },
                  ),
                ),
              ],
            ),

            _titleText('Ціна'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 98,
                  child: _textFields(_textPriceS, _validatePriceS, _validatePriceSSumb, 'Від'),
                ),
                SizedBox(width: 20),
                Container(
                  width: 98,
                  child: _textFields(_textPriceF, _validatePriceF, _validatePriceFSumb, 'До'),
                ),
              ],
            ),

            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    'СКИНУТИ',
                    style: TextStyle(color: brightTurquoise),
                  ),
                  onTap: () {
                    _textPriceS.clear();
                    _textPriceF.clear();
                  },
                ),
                SizedBox(width: 29),
                GestureDetector(
                  child: Text(
                    'ЗАСТОСУВАТИ',
                    style: TextStyle(color: brightTurquoise),
                  ),
                  onTap: () {
                    setState(() {
                      String pattern = r'^[0-9]+$';
                      RegExp regex = RegExp(pattern);

                      adsBrand == null ? _validateBrand = true : _validateBrand = false;
                      adsMaterial == null ? _validateMaterial = true : _validateMaterial = false;
                      adsSizeS == null ? _validateSizeS = true : _validateSizeS = false;
                      adsSizeF == null ? _validateSizeF = true : _validateSizeF = false;
                      _textPriceS.text.isEmpty ? _validatePriceS = true : _validatePriceS = false;
                      _textPriceF.text.isEmpty ? _validatePriceF = true : _validatePriceF = false;

                      if (_validatePriceS == false) {
                        !regex.hasMatch(_textPriceF.text) ? _validatePriceSSumb = true : _validatePriceSSumb = false;
                      }
                      if (_validatePriceF == false) {
                        !regex.hasMatch(_textPriceF.text) ? _validatePriceFSumb = true : _validatePriceFSumb = false;
                      }

                    });

                    if (_validateBrand == false &&
                        _validateMaterial == false &&
                        _validateSizeS == false &&
                        _validateSizeF == false &&
                        _validatePriceS == false &&
                        _validatePriceF == false &&
                        _validatePriceSSumb == false &&
                        _validatePriceFSumb == false)
                    {

                    } else {
                      Toast.show(
                        'Перевірте введені дані!',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        textColor: whiteColor,
                        backgroundColor: errorBgColor,
                        backgroundRadius: 20.0,
                      );
                    }
                  },
                ),
              ],
            ),

          ],
        ),
      );
  }
}
