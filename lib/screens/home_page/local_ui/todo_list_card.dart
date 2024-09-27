// local_ui/todo_card.dart
import 'package:intl/intl.dart';
import 'package:todo/logic/business_logic/home_page_logic.dart';
import 'package:todo/ui/global_constants.dart';

class ToDoCard extends StatelessWidget {
  final int id;
  final String name;
  final DateTime date;
  final int finishedTasksCount;
  final int totalTasksCount;

  const ToDoCard(
      {required this.id,
      required this.name,
      required this.date,
      required this.finishedTasksCount,
      required this.totalTasksCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HomePageLogic.onCardTap(context, this),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        color: PRIMARY_BROWN,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME
                  _buildNameText(name),
                  const SizedBox(height: 10),
                  // DATE
                  _buildDateText(date),
                ],
              ),
              _buildTaskCountText(
                  finishedTasksCount: finishedTasksCount,
                  totalTasksCount: totalTasksCount)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNameText(String name) {
  return Text(
    name,
    style: GoogleFonts.inter(
        fontSize: 32, fontWeight: FontWeight.w500, color: SECONDARY_RED),
  );
}

Widget _buildDateText(DateTime date) {
  return Text(
    DateFormat('dd MMM yyyy').format(date),
    style: const TextStyle(
        fontSize: 16, color: SECONDARY_RED, fontWeight: FontWeight.w500),
  );
}

Widget _buildTaskCountText(
    {int finishedTasksCount = 0, int totalTasksCount = 0}) {
  return Text(
    "$finishedTasksCount/$totalTasksCount",
    style: GoogleFonts.inter(
      color: SECONDARY_RED,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
  );
}
