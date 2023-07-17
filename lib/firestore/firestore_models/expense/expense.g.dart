// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Expense _$$_ExpenseFromJson(Map<String, dynamic> json) => _$_Expense(
      expenseId: json['expenseId'] as String? ?? '',
      money: json['money'] as int? ?? 0,
      createdAt: json['createdAt'] ?? const ServerTimestamp(),
    );

Map<String, dynamic> _$$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'money': instance.money,
      'createdAt': instance.createdAt,
    };
