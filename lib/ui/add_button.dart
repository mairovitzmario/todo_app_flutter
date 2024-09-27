import '../logic/business_logic/home_page_logic.dart';
import 'global_constants.dart';

class AddButton extends StatelessWidget {
  final Function(BuildContext) onPressedFunction;
  BuildContext context;
  AddButton(
      {super.key, required this.onPressedFunction, required this.context});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: FloatingActionButton.large(
          onPressed: () => onPressedFunction(context),
          backgroundColor: SECONDARY_RED,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 70,
          ),
        ),
      ),
    );
  }
}
