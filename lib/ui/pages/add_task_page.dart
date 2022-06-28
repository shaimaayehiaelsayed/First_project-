import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
final TaskController _taskController = Get.put(TaskController()) ;
final TextEditingController _titleController= TextEditingController();
final TextEditingController _descController= TextEditingController();
DateTime _selectionDate= DateTime.now();
String _startDate =DateFormat('hh:mm a').format(DateTime.now()).toString();
String _endDate = DateFormat('hh:mm a')
      .format(DateTime.now().add( const Duration(minutes: 15)))
      .toString();
int _selectedRemind=5;
List<int>remindList =[5,10,15,20];
String _selectedRepeat = 'None';
List <String>repeatList=['None','Daily','Weakly','Monthly'];
int _selectedColor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),

              InputField(
                title: 'Title',
                desc: 'Enter tilte here',
                controller:_titleController,),
              InputField(
                title: 'Note',
                desc: 'Enter Note',
                controller:_descController,),
              InputField(
                title: 'Date',
                desc: DateFormat.yMd().format(_selectionDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    _getDateFromUser();
                  },),),
              Row(
                children: [
                  Expanded(
                      child:InputField(
                        title: 'Start time',
                        desc:_startDate,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,),onPressed: (){
                            _getTimeFromUser(isStartTime: true);
                        },),),
                  ),
                  Expanded(
                    child:InputField(
                      title: 'End Time ',
                      desc:_endDate,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,),onPressed: (){
                        _getTimeFromUser(isStartTime: true);

                      },),),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                desc:'$_selectedRemind minutes Early',
                widget: Row(
                  children: [
                    DropdownButton(
                      items: remindList
                          .map(
                            (value) => DropdownMenuItem(
                            value: value,
                           child: Text(
                               '$value'
                           )
                      ),
                      ).toList(), onChanged: (int? newValue) {
                        setState(() {
                          _selectedRemind=newValue!;
                        });
                    },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined
                      ),
                      iconSize: 32,
                      dropdownColor: Colors.blueGrey,
                      elevation: 4,
                      underline: Container(height: 0,),
                      style: supTitleStyle,
                    ),
                    const SizedBox(width: 6,),
                  ],
                ),
                ),
              InputField(
                title: 'Repeat',
                desc:'$_selectedRepeat ',
                widget: Row(
                  children: [
                    DropdownButton(
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                                '$value'
                            )
                        ),
                      ).toList(), onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat=newValue!;
                      });
                    },
                      icon: const Icon(
                          Icons.keyboard_arrow_down_outlined
                      ),
                      iconSize: 32,
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 4,
                      underline: Container(height: 0,),
                      style: supTitleStyle,
                    ),
                    const SizedBox(width: 6,),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _selectColor(),
                  MyButton(label:'Create Task' ,onTap: (){_validateDate();},),
                ],
              ),

            ]
          ),
        ),
      ),
    );
  }


Column _selectColor(){
  return Column(
    children:  [
      Text('Color',style: titleStyle,),
      const SizedBox(height: 10,),
      Wrap (
        children:List<Widget>.generate(3, (index) =>
            GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor=index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor:index==0? primaryClr:index==1?pinkClr:orangeClr,
                  child: _selectedColor==index? const Icon(Icons.done,size: 16,color:Colors.white,):null,
                ),

              ),
            ),
        ),
      ),
    ],
  );
  }
  AppBar _appBar(){
    return AppBar(
      leading: IconButton(
        onPressed: ()=> Get.back(),icon:const Icon(Icons.arrow_back_ios,size: 14,color: primaryClr,),
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
  _validateDate(){
    if(_titleController.text.isNotEmpty && _descController.text.isNotEmpty){
      _addTasksToDb();
      Get.back();
    }else if (_titleController.text.isEmpty || _descController.text.isEmpty){
       Get.snackbar('required', 'All Field are required ',snackPosition:SnackPosition.BOTTOM,backgroundColor: Colors.white,colorText: pinkClr,icon: const Icon(
         Icons.warning_amber_rounded,color: Colors.red,));
    }else{
      print('###########something  wrong happened ');
    }
  }
  _addTasksToDb() async {
    try {
      int value = await _taskController.addTasks(
          task: Task(
            title: _titleController.text,
            note: _descController.text,
            date: DateFormat.yMMMMd().format(_selectionDate),
            startTime: _startDate,
            endTime: _endDate,
            isCompleted: 0,
            color: _selectedColor,
            repeat: _selectedRepeat,
            remind: _selectedRemind,

          )
      );
    }
    catch(e){
      print('Error');
    }
  }

   _getDateFromUser() async {
  DateTime? _pickedDate= await showDatePicker(context:context,
      initialDate:_selectionDate,
       firstDate:DateTime(2015),
      lastDate:DateTime(2030),);

     if (_pickedDate !=null) setState(() =>_selectionDate=_pickedDate);
     else print('It\s null or  somthing is wrong ');
  }

_getTimeFromUser( {required bool isStartTime}) async {
    TimeOfDay? _pickedTime= await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context:context,
        initialTime:isStartTime
          ?TimeOfDay.fromDateTime(DateTime.now())
          :TimeOfDay.fromDateTime(DateTime.now().add( const Duration(minutes: 15))));
    String _formattedTime =_pickedTime!.format(context);
    if(isStartTime){
      setState(() {
      _startDate=_formattedTime;
    });}
      else if (! isStartTime){
      setState(() {
        _endDate=_formattedTime;
      });}
        else {print('Time Canceled  or  somthing is wrong ');}

  }
}
