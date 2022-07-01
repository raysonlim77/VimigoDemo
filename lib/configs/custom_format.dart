import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class CustomFormat {
  static formatRmPrice(int price) =>
      'RM ${NumberFormat.currency(locale: "en_US", symbol: "").format(price / 100)}';

  static formatDate(DateTime date) => DateFormat("dd/MM/yyyy").format(date);
  static lastDay(DateTime date) =>
      DateFormat("dd/MM/yyyy").format(Jiffy(date).endOf(Units.MONTH).dateTime);
  static firstDay(DateTime date) => DateFormat("dd/MM/yyyy")
      .format(Jiffy(date).startOf(Units.MONTH).dateTime);
}
