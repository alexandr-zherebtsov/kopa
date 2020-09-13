import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopa/domain/ads.dart';
import 'package:kopa/models/add_ads_model.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/kopa_app_icons.dart';
import 'package:kopa/resources/styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';

bool formCheck = true;

List<String> adsImgUrls = [];
int numController;

class AddAds extends StatefulWidget {
  @override
  _AddAdsState createState() => _AddAdsState();
}

class _AddAdsState extends State<AddAds> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _sizesValue, _lengthValue, _widthValue, _brandValue, _materialValue;

  final _textDescription = TextEditingController();
  final _textPrice = TextEditingController();

  bool _validateImg = false;
  bool _validateSize = false;
  bool _validateLength = false;
  bool _validateWidth = false;
  bool _validateBrand = false;
  bool _validateMaterial = false;
  bool _validateDescription = false;
  bool _validatePrice = false;
  bool _validatePriceNum = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Додати взуття'),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 36,
            color: whiteColor,
          ),
          onPressed: () {
            adsImgUrls.clear();
            Navigator.pop(context);
          },
          tooltip: 'Повернутися',
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              'Зберегти',
              style: TextStyle(
                color: brightTurquoise,
              ),
            ),
            onPressed: () async {
              setState(() {
                String pattern = r'^[0-9]+$';
                RegExp regex = RegExp(pattern);

                adsImgUrls.length == 0 ? _validateImg = true : _validateImg = false;
                adsSize == null ? _validateSize = true : _validateSize = false;
                adsLength == null ? _validateLength = true : _validateLength = false;
                adsWidth == null ? _validateWidth = true : _validateWidth = false;
                adsBrand == null ? _validateBrand = true : _validateBrand = false;
                adsMaterial == null ? _validateMaterial = true : _validateMaterial = false;
                _textDescription.text.isEmpty ? _validateDescription = true : _validateDescription = false;
                _textPrice.text.isEmpty ? _validatePrice = true : _validatePrice = false;
                !regex.hasMatch(_textPrice.text) || _textPrice.text == '0000' || _textPrice.text == '000' || _textPrice.text == '00' ? _validatePriceNum = true : _validatePriceNum = false;

                if (formCheck) {
                  Future.delayed(const Duration(milliseconds: 5), () {
                    formCheck = false;
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    formCheck = true;
                  });
                }

              });

              if (formCheck) {
                if (_validateImg == false &&
                    _validateSize == false &&
                    _validateLength == false &&
                    _validateWidth == false &&
                    _validateBrand == false &&
                    _validateMaterial == false &&
                    _validateDescription == false &&
                    _validatePrice == false &&
                    _validatePriceNum == false)
                {
                  _formKey.currentState.save();
                  DocumentReference ref = await db.collection('adsData').add({
                    'adsSize': adsSize,
                    'adsLength': adsLength,
                    'adsWidth': adsWidth,
                    'adsBrand': adsBrand,
                    'adsMaterial': adsMaterial,
                    'adsDescription': adsDescription,
                    'adsPrice': adsPrice,
                    'imgUrls': adsImgUrls,
                  }).catchError((dataError) {
                    print(dataError);
                  });
                  id = ref.documentID;
                  Navigator.pop(context);
                  adsImgUrls.clear();
                } else {
                  print('Not correct data!');
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
              } else {
                print('Excess click');
              }
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                      Text('Додати фото', style: mediumTextName),
                    ],
                  ),
                ),
                Container(
                  color: mediumGray,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            height: 78,
                            minWidth: 78,
                            color: brightTurquoise,
                            child: Icon(KopaAppIcons.photo),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: ()  {
                               setState(() async {
                                await getImage();
                              });
                            },
                          ),

                          (adsImgUrls.length >= 1) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                          (adsImgUrls.length >= 1) ? InkWell(
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                color: whiteGrayBg,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage('${adsImgUrls[0]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ) : Container(),

                          (adsImgUrls.length >= 2) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                          (adsImgUrls.length >= 2) ? InkWell(
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                color: whiteGrayBg,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage('${adsImgUrls[1]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ) : Container(),

                          (adsImgUrls.length >= 3) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                          (adsImgUrls.length >= 3) ? InkWell(
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                color: whiteGrayBg,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage('${adsImgUrls[2]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ) : Container(),

                        ],
                      ),
                      (adsImgUrls.length >= 4) ? Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            (adsImgUrls.length >= 4) ? InkWell(
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: BoxDecoration(
                                  color: whiteGrayBg,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage('${adsImgUrls[3]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ) : Container(),

                            (adsImgUrls.length >= 5) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                            (adsImgUrls.length >= 5) ? InkWell(
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: BoxDecoration(
                                  color: whiteGrayBg,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage('${adsImgUrls[4]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ) : Container(),

                            (adsImgUrls.length >= 6) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                            (adsImgUrls.length >= 6) ? InkWell(
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: BoxDecoration(
                                  color: whiteGrayBg,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage('${adsImgUrls[5]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ) : Container(),

                            (adsImgUrls.length >= 7) ? SizedBox(width: (MediaQuery.of(context).size.width - 344)/3) : Container(),

                            (adsImgUrls.length >= 7) ? InkWell(
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: BoxDecoration(
                                  color: whiteGrayBg,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage('${adsImgUrls[6]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ) : Container(),

                          ],
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                      Text('Розмір', style: mediumTextName),
                    ],
                  ),
                ),
                Container(
                  color: mediumGray,
                  padding: const EdgeInsets.only(top: 18, bottom: 26, left: 48, right: 16),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        child: Image.asset('assets/icons/copa_size.png', width: 67, height: 189),
                      ),
                      Positioned(
                        top: 51,
                        child: Image.asset('assets/icons/arrow_horizontal.png', width: 67),
                      ),
                      Positioned(
                        left: 88,
                        child: Image.asset('assets/icons/arrow_vertical.png', height: 189),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 163.0),
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Розмір'),
                                DropdownButton(
                                  hint: Text('Розмір'),
                                  value: _sizesValue,
                                  iconEnabledColor: _validateSize ? errorColor : brightTurquoise,
                                  isExpanded: true,
                                  items: sizesList.map((val) {
                                    return DropdownMenuItem(
                                      child: Text(val),
                                      value: val,
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _sizesValue = val;
                                      adsSize = val;
                                      adsSize == null ? _validateSize = true : _validateSize = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Довжина / см'),
                                DropdownButton(
                                  hint: Text('Довжина'),
                                  value: _lengthValue,
                                  iconEnabledColor: _validateLength ? errorColor : brightTurquoise,
                                  isExpanded: true,
                                  items: lengthList.map((val) {
                                    return DropdownMenuItem(
                                      child: Text(val),
                                      value: val,
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _lengthValue = val;
                                      adsLength = val;
                                      adsLength == null ? _validateLength = true : _validateLength = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Ширина / см'),
                                DropdownButton(
                                  hint: Text('Ширина'),
                                  value: _widthValue,
                                  iconEnabledColor: _validateWidth ? errorColor : brightTurquoise,
                                  isExpanded: true,
                                  items: widthList.map((val) {
                                    return DropdownMenuItem(
                                      child: Text(val),
                                      value: val,
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _widthValue = val;
                                      adsWidth = val;
                                      adsWidth == null ? _validateWidth = true : _validateWidth = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                      Text('Модель', style: mediumTextName),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton(
                    hint: Text('Модель'),
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
                        adsBrand == null ? _validateBrand = true : _validateBrand = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                      Text('Матеріал', style: mediumTextName),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton(
                    hint: Text('Матеріал'),
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
                        adsMaterial == null ? _validateMaterial = true : _validateMaterial = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                      Text('Опис', style: mediumTextName),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _textDescription,
                    maxLength: 300,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    cursorColor: brightTurquoise,
                    decoration: InputDecoration(
                      errorText: _validateDescription ? 'Поле не повинне бути порожнім' : null,
                      errorStyle: smallErrorText,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lightGrayText),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: brightTurquoise),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: errorColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: brightTurquoise),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        adsDescription = val;
                      });
                    },
                  ),
                ),
                Container(
                  color: mediumGray,
                  margin: const EdgeInsets.only(top: 19),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                            Text('Ціна (грн)', style: mediumTextName),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _textPrice,
                          keyboardType: TextInputType.number,
                          cursorColor: brightTurquoise,
                          maxLength: 4,
                          decoration: InputDecoration(
                            counter: Offstage(),
                            errorText: _validatePrice ? 'Поле не повинне бути порожнім' : _validatePriceNum ? 'Невірна ціна' : null,
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
                            setState(() {
                              adsPrice = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 14),
                    ],
                  ),
                ),
                Container(
                  height: 51,
                  child: _validateImg ? Center(child: Text('Додайте хоча б одне фото', style: TextStyle(color: errorColor),)) :
                  _validateSize ? Center(child: Text('Вкажіть розмір', style: TextStyle(color: errorColor),)) :
                  _validateLength ? Center(child: Text('Вкажіть довжину', style: TextStyle(color: errorColor),)) :
                  _validateWidth ? Center(child: Text('Вкажіть ширину', style: TextStyle(color: errorColor),)) :
                  _validateBrand ? Center(child: Text('Вкажіть модель взуття', style: TextStyle(color: errorColor),)) :
                  _validateMaterial ? Center(child: Text('Вкажіть матеріал', style: TextStyle(color: errorColor),)) :
                  _validateDescription ? Center(child: Text('Опишіть Ваше взуття', style: TextStyle(color: errorColor),)) :
                  _validatePrice ? Center(child: Text('Вкажіть ціну', style: TextStyle(color: errorColor),)) :
                  _validatePriceNum ? Center(child: Text('Невірна ціна', style: TextStyle(color: errorColor),)) :
                  Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      final ref = FirebaseStorage().ref().child(text);
      var imageString = await ref.getDownloadURL();

      await Firestore.instance.collection('storage').document().setData({'url':imageString, 'location':text});

      String imgUrlToArr = imageString.toString().replaceAll('[', '');
      imgUrlToArr = imgUrlToArr.toString().replaceAll(']', '');
      adsImgUrls.add('$imgUrlToArr');
      numController += 1;

    } catch(e){
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }
  }

  Future<String> _uploadImageToFirebase(File image) async {
    try {
      int randomNumber = Random().nextInt(1000);
      final timeNow = DateTime.now().millisecondsSinceEpoch;
      String imageLocation = 'images/$randomNumber$timeNow.jpg';

      final StorageReference storageReference = FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      _addPathToDatabase(imageLocation);
      return imageLocation;
    } catch(e){
      print(e.message);
      return null;
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImageToFirebase(image);
  }

}
