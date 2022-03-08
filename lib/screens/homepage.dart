import 'package:auto_singer/screens/auftragserweiterung.dart';
import 'package:auto_singer/screens/dokumentation.dart';
import 'package:auto_singer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(backgroundColor: kWhite)
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        color: kGreyBG,
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Text('Tools',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kBlueText,
                ),
              ),
            ),
            itemSelector('Dokumentation', (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dokumentation()));
            }),
            itemSelector('Auftragserweiterung Intern', (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Auftragserweiterung()));
            }),
            itemSelector('Interner Bereich', (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Auftragserweiterung()));
            }),
          ],
        ),
      ),
    );
  }


  Widget itemSelector(String text, Function onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 60.0,
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: kGrey,
          width: 0.4
        )
      ),
      child: TextButton(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(Icons.file_present_outlined, size: 26.0, color: kOrange,),
            ),
            Text(text, style: TextStyle(
              fontSize: 15.0, color: kBlueText, fontWeight: FontWeight.w600),
            )
          ],
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }


}
