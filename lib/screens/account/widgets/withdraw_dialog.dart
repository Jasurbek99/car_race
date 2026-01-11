import 'package:flutter/material.dart';

import '../../../ui/style/app_style.dart';
import '../account_constants.dart';
import 'top_up_dialog.dart';

class WithdrawDialog extends StatefulWidget {
  const WithdrawDialog({super.key});

  @override
  State<WithdrawDialog> createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  NetworkType _selectedNetwork = NetworkType.bsc;
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  static const _availableBalance = 1255.00;

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.l),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 380),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.panelAlt,
            borderRadius: BorderRadius.circular(AppRadii.l),
            border: Border.all(color: AppColors.border, width: AppBorders.regular),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: AppSpacing.s),
                _NetworkSelector(
                  selected: _selectedNetwork,
                  onChanged: (network) => setState(() => _selectedNetwork = network),
                ),
                const SizedBox(height: AppSpacing.s),
                _buildAddressField(),
                const SizedBox(height: AppSpacing.s),
                _buildAmountField(),
                const SizedBox(height: AppSpacing.m),
                _buildWithdrawButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.panel,
              borderRadius: BorderRadius.circular(AppRadii.s),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              AccountStrings.withdrawTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AccountStrings.address,
          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: AppColors.panel.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadii.s),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _addressController,
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: AccountStrings.longPressToPaste,
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Icon(Icons.settings, color: AppColors.textMuted, size: 14),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AccountStrings.amount,
          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: AppColors.panel.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadii.s),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: AccountStrings.minimumAmount,
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _amountController.text = _availableBalance.toStringAsFixed(2);
                },
                child: const Text(
                  AccountStrings.max,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${AccountStrings.available} ${_availableBalance.toStringAsFixed(2)} USDT',
          style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _onWithdraw,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadii.m),
          ),
          child: const Center(
            child: Text(
              AccountStrings.withdraw,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onWithdraw() {
    Navigator.pop(context);
  }
}

class _NetworkSelector extends StatelessWidget {
  final NetworkType selected;
  final ValueChanged<NetworkType> onChanged;

  const _NetworkSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _NetworkButton(
            name: AccountStrings.bsc,
            subtitle: AccountStrings.bscFull,
            isSelected: selected == NetworkType.bsc,
            onTap: () => onChanged(NetworkType.bsc),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: _NetworkButton(
            name: AccountStrings.trx,
            subtitle: AccountStrings.trxFull,
            isSelected: selected == NetworkType.trx,
            onTap: () => onChanged(NetworkType.trx),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: _NetworkButton(
            name: AccountStrings.eth,
            subtitle: AccountStrings.ethFull,
            isSelected: selected == NetworkType.eth,
            onTap: () => onChanged(NetworkType.eth),
          ),
        ),
      ],
    );
  }
}

class _NetworkButton extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _NetworkButton({
    required this.name,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s,
          horizontal: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.s),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 8,
                  color: isSelected ? Colors.white70 : AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
