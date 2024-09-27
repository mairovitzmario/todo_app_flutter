import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/logic/business_logic/home_page_logic.dart';
import 'package:todo/logic/business_logic/todo_list_page_logic.dart';
import 'package:todo/ui/global_constants.dart';

class AddDialog extends StatelessWidget {
  final String page;
  final TextEditingController _textFieldController = TextEditingController();
  final String defaultName;

  AddDialog({super.key, this.page = 'home'})
      : defaultName = _setDefaultName(page);

  static String _setDefaultName(String page) {
    if (page == 'home') {
      return 'Unnamed list';
    } else {
      return 'New task';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: PRIMARY_BROWN,
      child: Container(
        width: 0.8 * MediaQuery.sizeOf(context).width,
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: _buildDialogContent(context),
      ),
    );
  }

  /// Builds the content of the dialog, including title and text field.
  Widget _buildDialogContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 10),
        _buildTextField(),
        const SizedBox(
          height: 30,
        ),
        _buildButton(context),
      ],
    );
  }

  /// Builds the title text widget for the dialog.
  Widget _buildTitle() {
    String titleText = page == 'home' ? 'Add a list' : 'Add a task';
    return Text(
      titleText,
      style: GoogleFonts.inter(
        color: SECONDARY_RED,
        fontSize: 50,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Builds the text field widget with customized decoration.
  Widget _buildTextField() {
    return TextField(
      controller: _textFieldController,
      autofocus: true,
      style: TextStyle(color: SECONDARY_RED, fontSize: 24),
      decoration: InputDecoration(
        hintText: defaultName,
        hintStyle:
            const TextStyle(color: SECONDARY_RED), // Custom hint text style

        prefixIcon: const Icon(
          Icons.edit,
          color: SECONDARY_RED, // Icon at the start of the TextField
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          borderSide: const BorderSide(color: SECONDARY_RED), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          borderSide: const BorderSide(color: Colors.white), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: SECONDARY_RED,
            width: 2.0, // Border color when focused
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0, // Padding inside the TextField
        ),
        filled: true,
        fillColor: Colors.white, // Background color of the TextField
      ),
    );
  }

  Widget _buildButton(context) {
    return Center(
      child: TextButton(
        onPressed: () {
          if (page == 'home') {
            HomePageLogic.pressConfirmDialog(
                context, _textFieldController, defaultName);
          } else {
            ToDoListPageLogic.pressConfirmDialog(
                context, _textFieldController, defaultName);
          }
        },
        child: Text('Confirm'),
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
            backgroundColor: WidgetStatePropertyAll(SECONDARY_RED),
            foregroundColor:
                WidgetStatePropertyAll(Colors.white), // Sets the text color
            textStyle: WidgetStatePropertyAll(GoogleFonts.inter(fontSize: 32)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
      ),
    );
  }
}
