import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:kopa/screens/advertisement.dart';

class KopsAdsWidget extends StatefulWidget {
  @override
  _KopsAdsWidgetState createState() => _KopsAdsWidgetState();
}

class _KopsAdsWidgetState extends State<KopsAdsWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('adsData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return !snapshot.hasData || snapshot.data.documents.isEmpty
                  ? Center(child: Text('Немає оголошень', style: mediumTextName))
                  : ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(snapshot.data.documents.length, (index) {
                  DocumentSnapshot currentDocument = snapshot.data.documents[index];
                  List<String> imgList = [currentDocument['imgUrls'][0].toString()];
                  String urlFromList = imgList[0].replaceAll('[', '');
                  urlFromList = urlFromList.replaceAll(']', '');
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Advertisement(),
                          ),
                        ),
                        child: Container(
                          margin: index == 0
                              ? const EdgeInsets.only(top: 60, bottom: 10, left: 16, right: 21)
                              : index == snapshot.data.documents.length - 1
                              ? const EdgeInsets.only(bottom: 36, left: 16, right: 21)
                              : const EdgeInsets.only(bottom: 10, left: 16, right: 21),
                          width: MediaQuery.of(context).size.width - 37,
                          height: 120,
                          decoration: BoxDecoration(
                            color: mediumGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  width: 140,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: blackColor,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      //image: AssetImage('assets/images/kopa_id0.png'),
                                      image: NetworkImage(urlFromList),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                        top: 3,
                                        left: 3,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              colors: [darkGray.withOpacity(0.6), darkGray.withOpacity(0.0)],
                                            ),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: Icon(
                                            Icons.favorite,
                                            color: likedRed,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 9,
                                left: 150,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width - 257,
                                          child: Text(
                                            currentDocument['adsBrand'],
                                            style: mediumTextName,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          ),
                                        ),
                                        SizedBox(height: 9),
                                        Text('Розміри стопи:', style: smallText),
                                      ],
                                    ),
                                    Container(
                                      width: 74,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: cashYellow,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text('${currentDocument['adsPrice']} грн', style: mediumTextCash),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 150,
                                top: 58,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 188,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(currentDocument['adsSize'], style: bigTurquoiseText),
                                              Text('EU', style: smallText),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(currentDocument['adsLength'] + ' см', style: mediumWhiteText),
                                              Text('Довжина', style: smallText),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(currentDocument['adsWidth'] + ' см', style: mediumWhiteText),
                                              Text('Ширина', style: smallText),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Матеріал: ${currentDocument['adsMaterial']}',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: smallTextSub,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
          }
        });
  }
}
