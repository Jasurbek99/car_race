import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../ui/style/app_style.dart';
import '../account_constants.dart';

enum NetworkType { bsc, trx, eth }

class TopUpDialog extends StatefulWidget {
  const TopUpDialog({super.key});

  @override
  State<TopUpDialog> createState() => _TopUpDialogState();
}

class _TopUpDialogState extends State<TopUpDialog> {
  NetworkType _selectedNetwork = NetworkType.bsc;

  static const _addresses = {
    NetworkType.bsc: '0xacenwi3i4njvvbnffke45njfvdkvnjkdfvn45vnjfdjsfdvnjsdknvjksn43',
    NetworkType.trx: 'TXacenwi3i4njvvbnffke45njfvdkvnjkdfvn45vnjfdjsfdvnjsdknvjksn43',
    NetworkType.eth: '0xethwi3i4njvvbnffke45njfvdkvnjkdfvn45vnjfdjsfdvnjsdknvjksn43',
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.l),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 350),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.panelAlt,
            borderRadius: BorderRadius.circular(AppRadii.l),
            border: Border.all(color: AppColors.border, width: AppBorders.regular),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: AppSpacing.s),
              _NetworkSelector(
                selected: _selectedNetwork,
                onChanged: (network) => setState(() => _selectedNetwork = network),
              ),
              const SizedBox(height: AppSpacing.s),
              Expanded(child: _buildContent()),
            ],
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
              AccountStrings.topUpTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  Widget _buildContent() {
    final address = _addresses[_selectedNetwork] ?? '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AccountStrings.address,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(fontSize: 10),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  GestureDetector(
                    onTap: () => _copyAddress(address),
                    child: const Icon(
                      Icons.copy,
                      color: AppColors.textMuted,
                      size: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: const [
                  Text(
                    AccountStrings.minimumDeposit,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AccountStrings.minimumDepositValue,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadii.s),
              ),
              child: Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 80,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _copyAddress(String address) {
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address copied'),
        duration: Duration(seconds: 2),
      ),
    );
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
