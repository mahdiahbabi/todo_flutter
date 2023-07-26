import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maaca_todo/model/model.dart';
import 'package:maaca_todo/view/creattask.dart';
import 'package:maaca_todo/view/edittask.dart';

const taskboxname = 'task';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CategoriAdapter());
  await Hive.openBox<Task>(taskboxname);
  runApp(const MyApp());
}

Color primaryColor = const Color(0xff4A3780);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(),
        ),
        // primaryColor: const Color(0xff4A3780),
        useMaterial3: true,
        primaryColor: primaryColor,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController _controller = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskboxname);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 212, 244),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => const CreatTask(),
          ),
        ),
        label: const Text('Add new Task'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height / 4,
              color: primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: Text(
                      'To do List',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 8, 15),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        label: Text('Search Task'),
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height,
              width: double.infinity,
              child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, box, index) {
                    return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          final Task task = box.values.toList()[index];
                          return Slidable(
                            //  startActionPane: ActionPane(motion: motion, children: children),
                            key: Key('$task'),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.7,
                                children: [
                                  Expanded(
                                    child: SlidableAction(
                                      onPressed: (context) {
                                        Navigator.of(context)
                                            .push(CupertinoPageRoute(
                                          builder: (context) =>
                                              EditTask(taskData: task),
                                        ));
                                      },
                                      backgroundColor: Colors.blueAccent,
                                      icon: CupertinoIcons.pen,
                                    ),
                                  ),
                                  Expanded(
                                    child: SlidableAction(
                                      label: 'delete',
                                      onPressed: (context) {
                                        task.delete();
                                      },
                                      backgroundColor: Colors.red,
                                      icon: CupertinoIcons.delete,
                                    ),
                                  ),
                                ]),

                            child: Container(
                              margin: const EdgeInsets.only(left: 9, right: 9),
                              width: double.infinity,
                              height: 85,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(19)),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(400),
                                        color: task.iscompleted
                                            ? Color(0xffE7E2F3)
                                            : Colors.purple.shade300,
                                      ),
                                      child: Icon(task.categori.name == 'study'
                                          ? CupertinoIcons.list_bullet
                                          : task.categori == 'work'
                                              ? CupertinoIcons.calendar
                                              : task.categori.name == 'sport'
                                                  ? CupertinoIcons.sportscourt
                                                  : CupertinoIcons.list_bullet),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 90.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.TaskTitle,
                                          style: TextStyle(
                                              fontSize: 25,
                                              decoration: task.iscompleted
                                                  ? TextDecoration.lineThrough
                                                  : null),
                                        ),
                                        Text(
                                          task.Time.toString().substring(0, 16),
                                          style: TextStyle(
                                              decoration: task.iscompleted
                                                  ? TextDecoration.lineThrough
                                                  : null),
                                        ),
                                        Text(task.categori.name)
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        task.iscompleted = !task.iscompleted;
                                      });
                                    },
                                    child: Container(
                                        width: 29,
                                        height: 29,
                                        decoration: BoxDecoration(
                                          color: task.iscompleted
                                              ? Colors.purple
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          border: Border.all(
                                              color: task.iscompleted
                                                  ? Colors.purple
                                                  : Colors.black,
                                              strokeAlign:
                                                  task.iscompleted ? 1 : 0),
                                        ),
                                        child: Center(
                                            child: task.iscompleted
                                                ? const Icon(
                                                    CupertinoIcons.check_mark,
                                                    color: Colors.white,
                                                  )
                                                : null)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
