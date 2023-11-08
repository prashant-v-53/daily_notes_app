import '../core/app_export.dart';
import '../presentation/auth/splash/splash_screen.dart';
import '../presentation/dashboard/add_notes/add_notes_screen.dart';
import '../presentation/dashboard/draw/draw.dart';
import '../presentation/dashboard/edit_label/edit_label_screen.dart';
import '../presentation/dashboard/edit_notes/edit_notes_screen.dart';
import '../presentation/dashboard/home/home_screen.dart';
import '../presentation/dashboard/label_name/label_name_screen.dart';
import '../presentation/dashboard/label_wise_note/label_wise_note_screen.dart';

class AppRoute {
  static String splash = '/splash';
  static String home = '/home';
  static String addNotes = '/addNotes';
  static String editNotes = '/editNotes';
  static String editLabel = '/editLabel';
  static String labelName = '/labelName';
  static String draw = '/draw';
  static String labelWiseNote = '/labelWiseNote';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: addNotes, page: () => AddNotesScreen()),
    GetPage(name: editNotes, page: () => EditNotesScreen()),
    GetPage(name: editLabel, page: () => EditLabelScreen()),
    GetPage(name: labelName, page: () => LabelNameScreen()),
    GetPage(name: draw, page: () => DrawScreen()),
    GetPage(name: labelWiseNote, page: () => LabelWiseNoteScreen()),
  ];
}
