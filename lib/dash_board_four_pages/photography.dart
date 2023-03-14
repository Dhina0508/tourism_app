import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGraphy extends StatefulWidget {
  PhotoGraphy({Key? key}) : super(key: key);

  @override
  State<PhotoGraphy> createState() => _PhotoGraphyState();
}

class _PhotoGraphyState extends State<PhotoGraphy> {
  var click = '';
  ImagePicker image = ImagePicker();
  File? file;

  String url = "";
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  geting_Photo() async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile =
        FirebaseStorage.instance.ref().child("Photography").child(name);

    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Photography").doc();
    return _CollectionReference.set({
      "img": url,
      "Time": DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Photos Has Been Posted Successfully"),
        behavior: SnackBarBehavior.floating,
      ));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "World Wide PhotoGraphy",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "JosefinSans"),
          ),
          centerTitle: true,
        ),
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: file == null
                        ? NetworkImage(
                            "https://t3.ftcdn.net/jpg/03/66/66/62/360_F_366666222_DCAdZ5uHSl1ckP1jbHVq7uzO8CFKvmhy.jpg")
                        : click == '1'
                            ? NetworkImage(
                                "https://t3.ftcdn.net/jpg/03/66/66/62/360_F_366666222_DCAdZ5uHSl1ckP1jbHVq7uzO8CFKvmhy.jpg")
                            : FileImage(File(file!.path)) as ImageProvider,
                    radius: 40,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      geting_Photo();
                      setState(() {
                        click = '1';
                      });
                    },
                    child: Text("Post")),
              ],
            ),
            Image.network(
              "https://static.toiimg.com/thumb/msid-92089121,width-748,height-499,resizemode=4,imgsize-139308/Most-beautiful-places-to-visit-in-India-for-first-timers.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://media.cntraveler.com/photos/5cb63a516b5c4dca7b5ec156/master/w_4000,h_2803,c_limit/Victoria-Falls-Zambia-Zimbabwe_GettyImages-507449285.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://media.cntraveler.com/photos/5cb63a273bf1dc125ade9aaf/master/w_4000,h_2667,c_limit/Machu-Picchu-Peru_GettyImages-109401484.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://media.easemytrip.com/media/Blog/India/637762882335748573/637762882335748573qOKUGH.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://www.pandotrip.com/wp-content/uploads/2018/07/San-Quirico-Val-d%E2%80%99Orcia-Tuscany-Italy.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZtSxz70hD3EkuWWtO-ew0Myzh-7oAcpCDQ&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaIXAIRHzchWdXvBmdeIumM7c4frmMf8-A3w&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUB64-WLQ_bfLYmWlByPp2iwQf4dHZ2Aoisg&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKdl4ykvLVKyrKrToBchNi3oBYeerah9SEJQ&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdR9fVoh9RQKHhxmR-yXSLSCssRF7Oz9PDuQ&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1yF2W40olZXEPVOV6-jD-AgEf9stI1ifZQw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTut47ZaqSU_Gu2w12VbMZsFB_B9u8nUVvVgQ&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrgUKta93QxzX4_waKVr-NI8E3zl8crPEjPw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNNs-ptMyeM1ROFm9YHHFX-ng7FoBLBx-c5Q&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnYNFDnXQy0NFzuxd1j44mR-fkefsqKObSEeVdGeb_omtf7ra79OOOo8PUZ_whd---LOI&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAAsOaXicfnAn4oNk6fpzvN220bmgliZoqKTA2Bk9ISqkdm4l2I-OOGCrV81CIEeuBPgc&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCy5fXJSm-mABqyEsZUxyZECOdXNMdXPTvng&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW4qY_FGm85TvpAiDfP8Noi2s3kczaS8JF0A&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP8uzAfzmLhPVIylhdaRXLm0npiknAzNMIag&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAt6pEDpGOfcqRe5gwsxM7RCvUpAgafocmRw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAxU8TcJ6Gd5MotBRMgKo5Nd9yk2PTy5aU0Q&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgqyQZLaDwEscLOhZ9KO8uHaosALwmsG2oSA&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTRAOaUiu0QdQCCOkuJ8rIkntZT_PEUrBtng&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrrB7M3eXfqrjk1OlhLIYcmGit-qc6WFIw7g&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSurQI2VkDc0J3bUOMLpBzjn1e70IR7b1Fypw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSurQI2VkDc0J3bUOMLpBzjn1e70IR7b1Fypw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTug0uqH9G5AWs2j8d43VfzOu-3UoBckTBkeA&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQkkUfpw5EUbeAOypzSbzgOYPP0ExKy5diMw&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://www.nativeplanet.com/img/2017/01/akshardham1-30-1485751909.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBGtr58jZEQX8bi2YSm-RDcYzY5Ik7SwIRU67o5M4HFK_rOiV1Iq7DHHs_QovyPwyMhJE&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThEwQ0dW9d7zJw7qK9ETLFD3GFHZt_y1CbXJ6rhpzA4-n7yZa6A8MhNTWZL-DRp9eFchs&usqp=CAU",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpP-sSCqOvSHvU2juFSfue7TK1eItPD8_fA9bcoPwBagu2qd4EPc52-449q5Vgor-uo_E&usqp=CAU",
              fit: BoxFit.cover,
            ),
          ],
        ));
  }
}
