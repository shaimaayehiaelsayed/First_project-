import 'package:flutter/material.dart';

import '../size_config.dart';
import '../theme.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.title,required this.desc, this.controller, this.widget}) : super(key: key);
  final String title;
  final String desc;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            height: 45,
            width: SizeConfig.screenWidth,
            decoration:  BoxDecoration(
              // color:primaryClr,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.grey
                )
            ),
            child:Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    readOnly: widget !=null?true:false,
                    decoration: InputDecoration(
                        hintText: desc,
                        hintStyle: supTitleStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                           color: context.theme.backgroundColor,
                          width: 0
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                        ),
                      ),

                    ),

                  ),
                ),
                widget??Container()
              ],
            ),),


        ],
      ),
      ),
    );
  }
}
