List sList() {
  double value = 16.0;

  List<String> sList = ['$value'];

  for (int i = 0; i < 64; i++) {
    value += 0.5;
    sList.add('$value');
  }

  return sList;
}

List lList() {
  double value = 9.5;

  List<String> lList = ['$value'];

  for (int i = 0; i < 47; i++) {
    value += 0.5;
    lList.add('$value');
  }

  return lList;
}

List wList() {
  double value = 6;

  List<String> wList = ['$value'];

  for (int i = 0; i < 12; i++) {
    value += 0.5;
    wList.add('$value');
  }

  return wList;
}

List<String> sizesList = sList();
List<String> lengthList = lList();
List<String> widthList = wList();

String sizesValue = sizesList[44];
String lengthValue = lengthList[30];
String widthValue = widthList[8];

const List<String> brandList = const [
  'Nike',
  'Adidas',
  'Puma',
  'Joma',
  'Lotto',
  'Umbro',
  'Mizuno',
  'Diadora',
  'Asics',
  'Kelme',
  'Under Armour',
  'Demix',
  'Reebok',
  'New Balance',
  'Fila',
  'Hummel',
  'Kappa',
];

String brandValue = brandList[0];

const List<String> materialList = const [
  'Натуральна шкіра',
  'Спеціальні штучні матеріали',
  'Штучна шкіра',
  'Замша',
  'Комбінована шкіра',
  'Замінник шкіри',
  'Нубук',
  'Повсть',
  'Текстиль',
];

String materialValue = materialList[0];
