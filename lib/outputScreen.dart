import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'model.dart';

class OutPutScreen extends StatefulWidget {
  final List<XFile> inputArr;
  const OutPutScreen({Key? key,  required this.inputArr}) : super(key: key);

  @override
  State<OutPutScreen> createState() => _OutPutScreenState();
}

class _OutPutScreenState extends State<OutPutScreen> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.inputArr.toString());
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height*1,
        width:MediaQuery.of(context).size.width*1,
       child:FutureBuilder(
         builder: (ctx, snapshot) {
           // Checking if future is resolved or not
           if (snapshot.connectionState == ConnectionState.done) {
             // If we got an error
             if (snapshot.hasError) {
               return Center(
                 child: Text(
                   '${snapshot.error} occurred',
                   style: TextStyle(fontSize: 18),
                 ),
               );

               // if we got our data
             } else if (snapshot.hasData) {
               // Extracting data from snapshot object
               Mymodel? mydata = snapshot.data;
               return Center(
                 child: Image.network(mydata?.outputUrl ??"")
               );
             }
           }

           // Displaying LoadingSpinner to indicate waiting state
           return Center(
             child: CircularProgressIndicator(),
           );
         },

         // Future that needs to be resolved
         // inorder to display something on the Canvas
         future: getDamageData(widget.inputArr[0]),
       ),
      ),
      );

  }
}

Future<Mymodel> getDamageData (XFile inputArr) async {
  var url ='https://vehicle-damage-assessment.p.rapidapi.com/run';
  List<int> imageBytes = File(inputArr.path).readAsBytesSync();
  print(imageBytes);
  String base64Image = base64Encode(imageBytes);

  var data= {"draw_result":true,"image":base64Image};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': 'f2b076a255mshc0a8285bb63d92ep1c8607jsn8463e7a86ffc',
        'X-RapidAPI-Host': 'vehicle-damage-assessment.p.rapidapi.com'
      },
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  final jsonResponse = json.decode(response.body);
  return Mymodel.fromJson(jsonResponse);

}
