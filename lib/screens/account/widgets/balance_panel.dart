import 'package:flutter/material.dart';

import '../../../ui/style/app_style.dart';
import '../account_constants.dart';
import 'top_up_dialog.dart';
import 'withdraw_dialog.dart';

enum TransactionType { deposit, withdrawal }

enum TransactionStatus { successful, declined, queue }

class Transaction {
  final TransactionType type;
  final String date;
  final double amount;
  final TransactionStatus status;

  const Transaction({
    required this.type,
    required this.date,
    required this.amount,
    required this.status,
  });
}

class BalancePanel extends StatelessWidget {
  const BalancePanel({super.key});

  static const _transactions = [
    Transaction(
      type: TransactionType.withdrawal,
      date: '12.11.2025',
      amount: -365.00,
      status: TransactionStatus.successful,
    ),
    Transaction(
      type: TransactionType.deposit,
      date: '12.11.2025',
      amount: 365.00,
      status: TransactionStatus.declined,
    ),
    Transaction(
      type: TransactionType.deposit,
      date: '12.11.2025',
      amount: 365.00,
      status: TransactionStatus.queue,
    ),
    Transaction(
      type: TransactionType.deposit,
      date: '12.11.2025',
      amount: 365.00,
      status: TransactionStatus.declined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.panelAlt.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadii.l),
        border: Border.all(color: AppColors.border, width: AppBorders.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppSpacing.l),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ActionButtons(
                  onTopUp: () => _showTopUpDialog(context),
                  onWithdraw: () => _showWithdrawDialog(context),
                ),
                const SizedBox(width: AppSpacing.l),
                const Expanded(child: _TransactionList(transactions: _transactions)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              AccountStrings.balance,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(AppRadii.s),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: const Icon(Icons.more_horiz, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  void _showTopUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const TopUpDialog(),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const WithdrawDialog(),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onTopUp;
  final VoidCallback onWithdraw;

  const _ActionButtons({required this.onTopUp, required this.onWithdraw});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: _ActionButton(
            icon: Icons.download_rounded,
            label: AccountStrings.topUp,
            onTap: onTopUp,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Flexible(
          child: _ActionButton(
            icon: Icons.upload_rounded,
            label: AccountStrings.withdraw,
            onTap: onWithdraw,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: 60,
        ),
        padding: const EdgeInsets.all(AppSpacing.xxs),
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(AppRadii.s),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadii.s),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const _TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.border.withValues(alpha: 0.3),
        height: AppSpacing.m,
      ),
      itemBuilder: (context, index) {
        return _TransactionItem(transaction: transactions[index]);
      },
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDeposit = transaction.type == TransactionType.deposit;
    final typeLabel = isDeposit
        ? AccountStrings.deposit
        : AccountStrings.withdrawal;
    final amountPrefix = isDeposit ? '+' : '';
    final amountText = '$amountPrefix${transaction.amount.toStringAsFixed(2)} USDT';

    return Row(
      children: [
        Icon(
          isDeposit ? Icons.add : Icons.remove,
          color: AppColors.textMuted,
          size: 14,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                typeLabel,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                transaction.date,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amountText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _getStatusText(transaction.status),
              style: TextStyle(
                fontSize: 9,
                fontStyle: FontStyle.italic,
                color: _getStatusColor(transaction.status),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.successful:
        return AccountStrings.successful;
      case TransactionStatus.declined:
        return AccountStrings.declined;
      case TransactionStatus.queue:
        return AccountStrings.queue;
    }
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.successful:
        return AppColors.positive;
      case TransactionStatus.declined:
        return const Color(0xFFE2514A);
      case TransactionStatus.queue:
        return AppColors.textMuted;
    }
  }
}
