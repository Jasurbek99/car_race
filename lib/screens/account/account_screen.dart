import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui/style/app_style.dart';
import '../../ui/widgets/bordered_icon_button.dart';
import '../../ui/widgets/token_chip.dart';
import 'account_constants.dart';
import 'widgets/balance_panel.dart';
import 'widgets/friends_panel.dart';
import 'widgets/personal_info_panel.dart';

enum AccountTab { personalInfo, balance, friends, historyRace }

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountTab _selectedTab = AccountTab.personalInfo;

  @override
  Widget build(BuildContext context) {
    final themedText = GoogleFonts.unboundedTextTheme(
      Theme.of(context).textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: themedText),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AccountAssets.roadBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0.65),
                ],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact =
                      constraints.maxWidth < AccountSizes.compactWidth;
                  return Padding(
                    padding: EdgeInsets.all(isCompact ? AppSpacing.m : AppSpacing.l),
                    child: Column(
                      children: [
                        _AccountTopBar(onBack: () => Navigator.maybePop(context)),
                        SizedBox(height: isCompact ? AppSpacing.m : AppSpacing.l),
                        Expanded(
                          child: isCompact
                              ? _CompactLayout(
                                  selectedTab: _selectedTab,
                                  onTabChanged: _onTabChanged,
                                )
                              : _WideLayout(
                                  selectedTab: _selectedTab,
                                  onTabChanged: _onTabChanged,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabChanged(AccountTab tab) {
    setState(() => _selectedTab = tab);
  }
}

class _AccountTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _AccountTopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BorderedIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              AccountStrings.account,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                TokenChip(
                  iconAsset: AccountAssets.coinIcon,
                  value: '15145.45',
                  iconBackground: AppColors.primary,
                ),
                SizedBox(width: AppSpacing.s),
                TokenChip(
                  iconAsset: AccountAssets.usdtIcon,
                  value: '1254.12',
                  iconBackground: AppColors.positive,
                ),
                SizedBox(width: AppSpacing.s),
                BorderedIconButton(icon: Icons.settings_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WideLayout extends StatelessWidget {
  final AccountTab selectedTab;
  final ValueChanged<AccountTab> onTabChanged;

  const _WideLayout({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NavColumn(selectedTab: selectedTab, onTabChanged: onTabChanged),
        const SizedBox(width: AppSpacing.l),
        Expanded(child: _buildPanel()),
      ],
    );
  }

  Widget _buildPanel() {
    switch (selectedTab) {
      case AccountTab.personalInfo:
        return const PersonalInfoPanel();
      case AccountTab.balance:
        return const BalancePanel();
      case AccountTab.friends:
        return const FriendsPanel();
      case AccountTab.historyRace:
        return const _HistoryRacePanel();
    }
  }
}

class _CompactLayout extends StatelessWidget {
  final AccountTab selectedTab;
  final ValueChanged<AccountTab> onTabChanged;

  const _CompactLayout({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NavRow(selectedTab: selectedTab, onTabChanged: onTabChanged),
        const SizedBox(height: AppSpacing.m),
        Expanded(child: _buildPanel()),
      ],
    );
  }

  Widget _buildPanel() {
    switch (selectedTab) {
      case AccountTab.personalInfo:
        return const PersonalInfoPanel();
      case AccountTab.balance:
        return const BalancePanel();
      case AccountTab.friends:
        return const FriendsPanel();
      case AccountTab.historyRace:
        return const _HistoryRacePanel();
    }
  }
}

class _NavColumn extends StatelessWidget {
  final AccountTab selectedTab;
  final ValueChanged<AccountTab> onTabChanged;

  const _NavColumn({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: AccountSizes.navPillMinWidth,
        maxWidth: AccountSizes.navPillMaxWidth,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NavPill(
              text: AccountStrings.personalInfo,
              isActive: selectedTab == AccountTab.personalInfo,
              onTap: () => onTabChanged(AccountTab.personalInfo),
            ),
            const SizedBox(height: AppSpacing.s),
            _NavPill(
              text: AccountStrings.balance,
              isActive: selectedTab == AccountTab.balance,
              onTap: () => onTabChanged(AccountTab.balance),
            ),
            const SizedBox(height: AppSpacing.s),
            _NavPill(
              text: AccountStrings.friends,
              isActive: selectedTab == AccountTab.friends,
              onTap: () => onTabChanged(AccountTab.friends),
            ),
            const SizedBox(height: AppSpacing.s),
            _NavPill(
              text: AccountStrings.historyRace,
              isActive: selectedTab == AccountTab.historyRace,
              onTap: () => onTabChanged(AccountTab.historyRace),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  final AccountTab selectedTab;
  final ValueChanged<AccountTab> onTabChanged;

  const _NavRow({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _NavPill(
            text: AccountStrings.personalInfo,
            isActive: selectedTab == AccountTab.personalInfo,
            onTap: () => onTabChanged(AccountTab.personalInfo),
            compact: true,
          ),
          const SizedBox(width: AppSpacing.s),
          _NavPill(
            text: AccountStrings.balance,
            isActive: selectedTab == AccountTab.balance,
            onTap: () => onTabChanged(AccountTab.balance),
            compact: true,
          ),
          const SizedBox(width: AppSpacing.s),
          _NavPill(
            text: AccountStrings.friends,
            isActive: selectedTab == AccountTab.friends,
            onTap: () => onTabChanged(AccountTab.friends),
            compact: true,
          ),
          const SizedBox(width: AppSpacing.s),
          _NavPill(
            text: AccountStrings.historyRace,
            isActive: selectedTab == AccountTab.historyRace,
            onTap: () => onTabChanged(AccountTab.historyRace),
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final bool compact;

  const _NavPill({
    required this.text,
    required this.isActive,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = isActive ? AppColors.primary : AppColors.panelAlt;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: compact ? AppSpacing.xs : AppSpacing.s,
          horizontal: compact ? AppSpacing.s : AppSpacing.s,
        ),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(color: AppColors.border, width: AppBorders.regular),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              fontSize: compact ? 11 : 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryRacePanel extends StatelessWidget {
  const _HistoryRacePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.panelAlt.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadii.l),
        border: Border.all(color: AppColors.border, width: AppBorders.regular),
      ),
      child: const Center(
        child: Text(
          'Race history coming soon',
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
      ),
    );
  }
}
