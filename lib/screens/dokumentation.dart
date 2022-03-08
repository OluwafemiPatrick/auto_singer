import 'dart:io';

import 'package:auto_singer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';

class Dokumentation extends StatefulWidget {
  const Dokumentation({Key? key}) : super(key: key);

  @override
  _DokumentationState createState() => _DokumentationState();
}

class _DokumentationState extends State<Dokumentation> {

  List<File> imageFile = [];
  String barcode = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        iconTheme: IconThemeData(color: kBlueText, size: 10),
        title: Text('Dokumentation',
          style: TextStyle(fontSize: 16.0, color: kBlueText),
        ),
        elevation: 1,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        color: kGreyBG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text('Barcode',
                style: TextStyle(fontSize: 15.0, color: kBlack),
              ),
            ),
            Visibility(
              visible: barcode.isNotEmpty,
              child: Text(barcode,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kBlueText),
              ),
            ),
            Container(
              width: 140.0,
              height: 32.0,
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: kBlueText.withOpacity(0.40),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: kWhite, size: 16.0,),
                    Text('Scan Barcode',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kWhite),
                    ),
                  ],
                ),
                onPressed: () {
                  scanBarcodeNormal();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('Foto erstellen',
                style: TextStyle(fontSize: 15.0, color: kBlack),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: imageFile.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0
                        ),
                        itemBuilder: (context, index) {
                          return imageListView(imageFile[index]);
                        }
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3,)
                  ],
                ),
              ),
            ),
            selectImageToUpload(),
            SizedBox(height: 20.0,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 48.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kOrange
                ),
                child: Center(
                  child: Text(
                    'Absenden',
                    style: TextStyle(color: kWhite, fontSize: 14.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,)
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    }
    on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      barcode = barcodeScanRes;
    });
  }

  Widget imageListView(File imageFile) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Image.file(imageFile, fit: BoxFit.fill),
    );
  }

  Widget selectImageToUpload() {
    return Container(
      height: 90.0,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          color: kOrange.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: kGrey,
            width: 0.4
        )
      ),
      child: TextButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload, color: kGrey, size: 30.0,),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.0),
              child: Text(
                'Dateien wahlen',
                style: TextStyle(fontSize: 15.0, color: kBlack)
                ),
            ),
            Text('Choose a file', style: TextStyle(
                fontSize: 14.0, color: kBlack, fontWeight: FontWeight.w200),)
          ],
        ),
        onPressed: () {
          if (imageFile.length < 11) {
            openCameraDialog(context);
          }
        },
      ),
    );
  }

  Future openCameraDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 160.0,
              child: Column(
                  children: <Widget>[
                    Text("Select image from",
                      style: TextStyle(fontSize: 18.0, color: kBlueText,)
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            _getImageFromCamera();
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset("assets/images/image_camera.jpeg", height: 50.0, width: 50.0,),
                              SizedBox(height: 6.0,),
                              Text("Camera", style: TextStyle(fontSize: 14.0),)
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _getImageFromGallery();
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset("assets/images/image_gallery.png", height: 50.0, width: 50.0,),
                              SizedBox(height: 6.0,),
                              Text("Gallery", style: TextStyle(fontSize: 14.0),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          );
        }
    );
  }

  Future<void> _getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile.add(File(photo!.path));
    });
  }

  Future<void> _getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile.add(File(image!.path));
    });
  }


}
