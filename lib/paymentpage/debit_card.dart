import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/const/themeColor.dart';
import 'package:food_delivery/paymentpage/payment_success.dart';
import 'package:food_delivery/widgets/profile_tile.dart';

class CreditCardPage extends StatelessWidget {
  final MaskedTextController ccMask =
  MaskedTextController(mask: "0000 0000 0000 0000");
  final MaskedTextController expMask = MaskedTextController(mask: "00/00");

  Widget bodyData(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          color: Colors.white10,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 35, 15),
                child: GestureDetector(
                  child: Icon(
                    CupertinoIcons.back,
                    size: 38,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                'Debit/Credit card',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ],
          ),
        ),
        creditCardWidget(context),
        fillEntries()
      ],
    ),
  );

  Widget creditCardWidget(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(decoration: BoxDecoration(color: Themes.color)),
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                child: cardEntries(),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  initialData: "Your Name",
                  builder: (context, snapshot) => Text(
                    snapshot.data?.isNotEmpty == true
                        ? snapshot.data!
                        : "Your Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 20.0),
                  ),
                  stream: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<String>(
          initialData: "**** **** **** ****",
          builder: (context, snapshot) {
            if (snapshot.data?.isNotEmpty == true) {
              ccMask.updateText(snapshot.data!);
            }
            return Text(
              snapshot.data?.isNotEmpty == true
                  ? snapshot.data!
                  : "**** **** **** ****",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            );
          },
          stream: null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
              initialData: "MM/YY",
              builder: (context, snapshot) {
                if (snapshot.data?.isNotEmpty == true) {
                  expMask.updateText(snapshot.data!);
                }
                return ProfileTile(
                  textColor: Colors.black,
                  title: "Expiry",
                  subtitle: snapshot.data?.isNotEmpty == true
                      ? snapshot.data!
                      : "MM/YY",
                );
              }, stream: null,
            ),
            SizedBox(
              width: 30.0,
            ),
            StreamBuilder<String>(
              initialData: "***",
              builder: (context, snapshot) => ProfileTile(
                textColor: Colors.black,
                title: "CVV",
                subtitle: snapshot.data?.isNotEmpty == true
                    ? snapshot.data!
                    : "***",
              ),
              stream: null,
            ),
          ],
        ),
      ],
    ),
  );

  Widget fillEntries() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: ccMask,
          keyboardType: TextInputType.number,
          maxLength: 19,
          style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          decoration: InputDecoration(
              labelText: "Credit Card Number",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              border: OutlineInputBorder()),
        ),
        TextField(
          controller: expMask,
          keyboardType: TextInputType.number,
          maxLength: 5,
          style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "MM/YY",
              border: OutlineInputBorder()),
        ),
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 3,
          style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "CVV",
              border: OutlineInputBorder()),
        ),
        TextField(
          keyboardType: TextInputType.text,
          maxLength: 20,
          style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Name on card",
              border: OutlineInputBorder()),
        ),
      ],
    ),
  );

  Widget floatingBar(BuildContext context) => Ink(
    decoration: ShapeDecoration(
      shape: StadiumBorder(),
    ),
    child: FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => PaymentSuccessPage()));
      },
      backgroundColor: Themes.color,
      icon: Icon(
        FontAwesomeIcons.amazonPay,
        color: Colors.black,
      ),
      label: Text(
        "Continue",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(context),
      floatingActionButton: floatingBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
