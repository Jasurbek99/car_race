import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/transaction.dart';

class BalancePanelNew extends StatelessWidget {
  final List<Transaction> transactions;

  const BalancePanelNew({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadii.m),
        border: Border.all(color: AppColors.border, width: AppBorders.regular),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Expanded(
            child: transactions.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions yet',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.separated(
                    itemCount: transactions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s),
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _TransactionItem(transaction: transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction.amount >= 0;
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final negativeColor = Colors.red.shade400;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.panelAlt.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadii.s),
      ),
      child: Row(
        children: [
          Icon(
            _getIconForType(transaction.type),
            color: isPositive ? AppColors.positive : negativeColor,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(transaction.date),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: isPositive ? AppColors.positive : negativeColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(TransactionType type) {
    switch (type) {
      case TransactionType.topUp:
        return Icons.add_circle_outline;
      case TransactionType.withdraw:
        return Icons.remove_circle_outline;
      case TransactionType.race:
        return Icons.emoji_events_outlined;
      case TransactionType.purchase:
        return Icons.shopping_cart_outlined;
    }
  }
}
