import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final  String payload;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payLoad='';
  @override
  void initState(){
      super.initState();
      _payLoad=widget.payload;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(),icon:const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          _payLoad.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode?Colors.white:darkGreyClr),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),

      body:  SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Column
              (
                children:
                [
                  Text(
                    'Hello , Hassan ',
                   style: TextStyle(
                     fontSize: 20,
                   fontWeight: FontWeight.w900,
                   color: Get.isDarkMode?Colors.white:darkGreyClr,)
                  ),
                  const SizedBox(height: 10,),
                  Text(
                      'you have a new reminder ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Get.isDarkMode?Colors.grey[100]:darkGreyClr,)
                  ),
                ],
              ),
            const SizedBox(height: 10,),
           Expanded(
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               margin: const EdgeInsets.symmetric(horizontal: 20),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                   color: primaryClr,
               ),
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: const [
                         Icon(Icons.text_format_outlined,color: Colors.white,),
                         SizedBox(width: 10,),
                         Text(
                           'Title',
                           style: TextStyle(color: Colors.white,fontSize: 30),
                         ),

                       ],
                     ),
                     const SizedBox(height: 20,),
                     Text(
                       _payLoad.toString().split('|')[0],
                       style: const TextStyle(color: Colors.white,fontSize: 20),
                     ),
                     const SizedBox(height: 20,),
                     Row(
                       children: const [
                         Icon(Icons.description,color: Colors.white,),
                         SizedBox(width: 10,),
                         Text(
                           'Description',
                           style: TextStyle(color: Colors.white,fontSize: 30),
                         ),

                       ],
                     ),
                     const SizedBox(height: 20,),
                     Text(
                       _payLoad.toString().split('|')[1],
                       style: const TextStyle(color: Colors.white,fontSize: 20),
                     ),
                     const SizedBox(height: 20,),
                     Row(
                       children: const [
                         Icon(Icons.calendar_today_outlined,color: Colors.white,),
                         SizedBox(width: 10,),
                         Text(
                           'Date',
                           style: TextStyle(color: Colors.white,fontSize: 30),
                         ),

                       ],
                     ),
                     const SizedBox(height: 20,),
                     Text(
                       _payLoad.toString().split('|')[2],
                       style: const TextStyle(color: Colors.white,fontSize: 20),
                     ),
                   ],
                 ),
               ),


             ),
           ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

}
