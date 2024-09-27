import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/home_page/local_ui/todo_list_card.dart';
import '../../ui/global_constants.dart';
import '../../ui/add_button.dart';
import 'local_ui/card_list.dart';
import '../../logic/database.dart';
import '../../logic/business_logic/home_page_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  // Separate function to load ToDoCards asynchronously

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do',
          style: GoogleFonts.inter(
              color: SECONDARY_RED, fontSize: 40, fontWeight: FontWeight.w500),
        ),
        backgroundColor: PRIMARY_BROWN,
      ),
      body: const CardList(),
      floatingActionButton: AddButton(
        onPressedFunction: HomePageLogic.pressAddButton,
        context: context,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
