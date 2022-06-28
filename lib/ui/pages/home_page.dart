
//import 'dart:js';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Date = DateFormat.yMMMMd().format(DateTime.now());
  DateTime _selectedDate=DateTime.now();
  final TaskController _taskController = Get.put(TaskController()) ;
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper =NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          showTask(),
        ],
      ),
    );
  }
  AppBar _appBar(){
    return AppBar(
      leading: IconButton(
        onPressed: (){ ThemeServices().switchTheme();
       // NotifyHelper().displayNotification(Title: 'theme change', body: 'fdf');
       // NotifyHelper().scheduledNotification();
        },
        icon: Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.nightlight_round,size: 14,color:Get .isDarkMode?Colors.white: darkGreyClr,),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(width: 16,),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              Date,
                style: supHeadingStyle,
              ),
              Text('Today',style: headingStyle,),
            ],
          ),
          MyButton(label: '+ add task', onTap:() async {
           await Get.to(()=>const AddTaskPage());
           _taskController.getTask();
          }),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 6),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate:DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        onDateChange: (newDate){
          _selectedDate=newDate;
        },
        dateTextStyle: GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontWeight: FontWeight.w600,
                color:Colors.grey,fontSize: 20)
        ),
        dayTextStyle:  GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontWeight: FontWeight.w600,
                color:Colors.grey,fontSize: 20)
        ),
        monthTextStyle:GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontWeight: FontWeight.w600,
                color:Colors.grey,fontSize: 20)
        ),
      ),
    );
  }
 Future <void>_onRefresf()async {
_taskController.getTask();
}
  showTask() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        }
        else {
          return RefreshIndicator(
            onRefresh: _onRefresf,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.taskList[index];
                var date = DateFormat().add_jm().parse(task.startTime!);
                var myTime = DateFormat('HH:mm ').format(date);
                NotifyHelper().scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]), task);
                return AnimationConfiguration.staggeredList(
                  duration: const Duration(milliseconds: 1375),
                  position: index,
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                              context, task);
                        },
                        child: TaskTile(task),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _taskController.taskList.length,
            ),
          );
        }} ),
    );

  }
  _noTaskMsg(){
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresf,
            child: SingleChildScrollView(
              child: Wrap(
                direction: SizeConfig.orientation==Orientation.landscape?
                Axis.horizontal:Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizeConfig.orientation==Orientation.landscape?
                      const SizedBox(height: 6,)
                     :const SizedBox(height:220,),
                  SvgPicture.asset('assets/images/task.svg',color: primaryClr.withOpacity(0.5),height: 90,semanticsLabel: 'Task image',),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text(
                        'you do not have any tasks yet ! \n add new task to make your day productive',
                      style: supTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation==Orientation.landscape?
                  const SizedBox(height: 180,) :const SizedBox(height: 120,),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
  showBottomSheet(BuildContext context,Task task){
    Get.bottomSheet(
        SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top:4),
          height:( SizeConfig.orientation==Orientation.landscape)
            ?(task.isCompleted==1
              ? SizeConfig.screenHeight*0.6
              : SizeConfig.screenHeight*0.8)
             :(task.isCompleted==1
              ? SizeConfig.screenHeight*0.30
              : SizeConfig.screenHeight*0.39),
          width: SizeConfig.screenWidth,
          color:Get.isDarkMode?darkHeaderClr:Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                   height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              task.isCompleted==1?Container():
              _buildBottomSheet(label: 'is Completed', onTap: (){
                Get.back();
              }, clr: primaryClr),
              _buildBottomSheet(label: 'delete Completed', onTap: (){
                Get.back();
              }, clr: primaryClr),
              Divider(color: Get.isDarkMode?Colors.grey:darkGreyClr,),
              _buildBottomSheet(label: 'Cancel', onTap: (){
                Get.back();
              }, clr: primaryClr),
              const SizedBox(height: 20,),

            ],

        ),
      ),
    ));

  }
  _buildBottomSheet({
    required String  label,
    required Function() onTap,
    required Color clr,
    bool isClose=false,}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose?Get.isDarkMode?Colors.grey[600]!
                :Colors.grey[300]!
                :clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            label,
            style:isClose? titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
  
}
