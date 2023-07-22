import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_json_converters/flutterfire_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    @Default('') String expenseId,
    @Default(0) int money,
    @alwaysUseServerTimestampSealedTimestampConverter
    @Default(ServerTimestamp())
    SealedTimestamp createdAt,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  factory Expense.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Expense.fromJson(<String, dynamic>{
      ...data,
      'expenseId': ds.id,
    });
  }

  const Expense._();
}
