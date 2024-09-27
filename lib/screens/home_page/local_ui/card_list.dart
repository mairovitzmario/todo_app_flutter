import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/home_page/local_ui/todo_list_card.dart';
import '../../../logic/providers/to_do_lists_provider.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    // Access the cardList once to avoid multiple calls to context.watch
    var toDoLists = context.watch<ToDoListsProvider>().toDoLists;
    List<ToDoCard> cardList = [];

    for (int i = 0; i < toDoLists.length; i++) {
      int? listId = toDoLists[i].id;
      if (listId != null) {
        cardList.add(ToDoCard(
            id: listId,
            name: toDoLists[i].name,
            date: toDoLists[i].date,
            finishedTasksCount: toDoLists[i].getFinishedTasksCount(),
            totalTasksCount: toDoLists[i].taskList.length));
      }
    }

    return ListView(
      children: <Widget>[
        for (int index = 0; index < cardList.length; index += 1)
          Container(
            color: Colors.transparent,
            key: Key('$index'),
            child: cardList[index],
          ),
      ],
    );
  }
}
