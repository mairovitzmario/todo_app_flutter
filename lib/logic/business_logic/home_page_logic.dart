import 'package:todo/logic/providers/to_do_lists_provider.dart';
import 'package:todo/screens/todo_list_page/todo_list_page.dart';
import 'package:todo/ui/global_constants.dart';
import 'package:provider/provider.dart';
import '../../ui/add_dialog.dart';
import '../database.dart';
import '../../screens/home_page/local_ui/todo_list_card.dart';
import '../models/to_do_list_model.dart';

class HomePageLogic {
// Home Page Add Button
  static void pressAddButton(BuildContext context) {
    showDialog(context: context, builder: (context) => AddDialog());
  }

//Dialog
  static void pressConfirmDialog(BuildContext context,
      TextEditingController controller, String defaultText) async {
    late String listName;

    if (controller.text.isEmpty) {
      listName = defaultText;
    } else {
      listName = controller.text;
    }

    var db = ToDoDatabase.instance;
    var pushedList = await db.insertList(ToDoListModel(name: listName));

    context.read<ToDoListsProvider>().addList(pushedList);

    Navigator.of(context).pop();
  }

  static void onCardTap(BuildContext context, ToDoCard tappedCard) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TodoListPage(id: tappedCard.id)));
  }
}
