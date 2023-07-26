import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maaca_todo/main.dart';
import 'package:maaca_todo/model/model.dart';

final taskboxname = 'task';

class CreatTask extends StatefulWidget {
  const CreatTask({super.key});

  @override
  State<CreatTask> createState() => _CreatTaskState();
}



class _CreatTaskState extends State<CreatTask> {
  DateTime dateTime = DateTime(2023, 2, 1);
  DateTime dateTime_time = DateTime(2040, 2, 1, 10, 20);

  final TextEditingController _controller_tasktitle = TextEditingController();
  final TextEditingController _controller_taskdetail = TextEditingController();
  bool work = false;
  bool study = false;
  bool sport = false;
  final task = Task();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          task.TaskTitle = _controller_tasktitle.text;
          task.TaskDetail = _controller_taskdetail.text;
          task.iscompleted = false;
          task.Time = dateTime_time;
          task.categori = work
              ? Categori.work
              : study
                  ? Categori.study
                  : sport
                      ? Categori.sport
                      : Categori.study;
          if (task.isInBox) {
            task.save();
          } else {
            final Box<Task> box = Hive.box(taskboxname);
            box.add(task);
          }
          Navigator.pop(context);
        },
        label: Text('Save  Task'),
      ),
      backgroundColor: const Color(0xffE0E0E0),
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Task Title',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: _controller_tasktitle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Task Title'),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text('Category'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          work = !work;
                        });
                      },
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(side: BorderSide(color: Colors.white)),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.list_bullet,
                        color: work ? Colors.blueAccent : Colors.purple,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          study = !study;
                        });
                      },
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(side: BorderSide(color: Colors.white)),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.calendar,
                        color: study ? Colors.blueAccent : Colors.purple,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sport = !sport;
                        });
                      },
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(side: BorderSide(color: Colors.white)),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.money_dollar,
                        color: sport ? Colors.blueAccent : Colors.purple,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date'),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 165,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                strokeAlign: 0.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child:
                                    Text(dateTime.toString().substring(0, 10)),
                              ),
                              IconButton(
                                onPressed: () => showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Expanded(
                                    child: SizedBox(
                                      width: size.width,
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        initialDateTime: dateTime,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() {
                                            dateTime = DateTime(newTime.year,
                                                newTime.month, newTime.day);
                                          });
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ),
                                  ),
                                ),
                                icon: Icon(CupertinoIcons.calendar,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time'),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 165,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                strokeAlign: 0.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    dateTime_time.toString().substring(11, 19)),
                              ),
                              IconButton(
                                onPressed: () => showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      initialDateTime: dateTime,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          dateTime_time = newTime;
                                        });
                                      },
                                      mode: CupertinoDatePickerMode.time,
                                    ),
                                  ),
                                ),
                                icon: Icon(CupertinoIcons.clock,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Note',
                    style: TextStyle(fontSize: 19, color: Colors.black),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: double.infinity,
                  height: 310,
                  child: Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      controller: _controller_taskdetail,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text("Task drtaile")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

