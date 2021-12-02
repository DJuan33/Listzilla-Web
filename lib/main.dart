import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/home/home_screen.dart';
import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/models/pomodoro_model.dart';
import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/models/user_model.dart';

void main() async {
  // Ensure Widget binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Start Hive.
  await Hive.initFlutter();

  // Register Hive adapters.
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(GroupListAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PomodoroAdapter());

  // Open Hive Boxes
  await Hive.openBox<Task>('TASK');
  await Hive.openBox<TaskList>('LIST');
  await Hive.openBox<GroupList>('GROUP');
  await Hive.openBox<User>('USER');
  await Hive.openBox<Pomodoro>('POMODORO');

  AppDependencies.injectDependencies();

  runApp(const Listzilla());
}

class Listzilla extends StatefulWidget {
  const Listzilla({Key? key}) : super(key: key);

  @override
  _ListzillaState createState() => _ListzillaState();
}

class _ListzillaState extends State<Listzilla> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
