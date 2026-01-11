import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_constants.dart';
import '../../../../ui/style/app_style.dart';
import '../../../../ui/widgets/bordered_icon_button.dart';
import '../../../../ui/widgets/token_chip.dart';
import '../../domain/entities/friend.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/account_providers.dart';
import '../widgets/balance_panel_new.dart';
import '../widgets/friends_panel_new.dart';
import '../widgets/personal_info_panel_new.dart';

enum AccountTab { personalInfo, balance, friends, historyRace }

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  static const routeName = '/account-new';

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  AccountTab _selectedTab = AccountTab.personalInfo;

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountNotifierProvider);
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
                    padding: EdgeInsets.all(
                      isCompact ? AppSpacing.m : AppSpacing.l,
                    ),
                    child: Column(
                      children: [
                        _AccountTopBar(
                          onBack: () => Navigator.maybePop(context),
                        ),
                        SizedBox(
                          height: isCompact ? AppSpacing.m : AppSpacing.l,
                        ),
                        Expanded(
                          child: accountState.when(
                            initial: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loaded: (profile, transactions, friends) =>
                                isCompact
                                ? _CompactLayout(
                                    profile: profile,
                                    transactions: transactions,
                                    friends: friends,
                                    selectedTab: _selectedTab,
                                    onTabChanged: _onTabChanged,
                                  )
                                : _WideLayout(
                                    profile: profile,
                                    transactions: transactions,
                                    friends: friends,
                                    selectedTab: _selectedTab,
                                    onTabChanged: _onTabChanged,
                                  ),
                            error: (message) => _ErrorContent(
                              message: message,
                              onRetry: () => ref
                                  .read(accountNotifierProvider.notifier)
                                  .retry(),
                            ),
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
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                AccountStrings.account,
                maxLines: 1,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        const Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
        ),
      ],
    );
  }
}

class _CompactLayout extends StatelessWidget {
  final UserProfile profile;
  final List<Transaction> transactions;
  final List<Friend> friends;
  final AccountTab selectedTab;
  final void Function(AccountTab) onTabChanged;

  const _CompactLayout({
    required this.profile,
    required this.transactions,
    required this.friends,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NavRow(selectedTab: selectedTab, onTabChanged: onTabChanged),
        const SizedBox(height: AppSpacing.m),
        Expanded(child: _getContentForTab()),
      ],
    );
  }

  Widget _getContentForTab() {
    switch (selectedTab) {
      case AccountTab.personalInfo:
        return PersonalInfoPanelNew(profile: profile);
      case AccountTab.balance:
        return BalancePanelNew(transactions: transactions);
      case AccountTab.friends:
        return FriendsPanelNew(friends: friends);
      case AccountTab.historyRace:
        return const Center(
          child: Text(
            'Race history coming soon',
            style: TextStyle(color: Colors.white54),
          ),
        );
    }
  }
}

class _WideLayout extends StatelessWidget {
  final UserProfile profile;
  final List<Transaction> transactions;
  final List<Friend> friends;
  final AccountTab selectedTab;
  final void Function(AccountTab) onTabChanged;

  const _WideLayout({
    required this.profile,
    required this.transactions,
    required this.friends,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 200,
          child: _NavColumn(
            selectedTab: selectedTab,
            onTabChanged: onTabChanged,
          ),
        ),
        const SizedBox(width: AppSpacing.l),
        Expanded(child: _getContentForTab()),
      ],
    );
  }

  Widget _getContentForTab() {
    switch (selectedTab) {
      case AccountTab.personalInfo:
        return PersonalInfoPanelNew(profile: profile);
      case AccountTab.balance:
        return BalancePanelNew(transactions: transactions);
      case AccountTab.friends:
        return FriendsPanelNew(friends: friends);
      case AccountTab.historyRace:
        return const Center(
          child: Text(
            'Race history coming soon',
            style: TextStyle(color: Colors.white54),
          ),
        );
    }
  }
}

class _NavRow extends StatelessWidget {
  final AccountTab selectedTab;
  final void Function(AccountTab) onTabChanged;

  const _NavRow({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _NavButton(
            label: AccountStrings.personalInfo,
            isSelected: selectedTab == AccountTab.personalInfo,
            onTap: () => onTabChanged(AccountTab.personalInfo),
          ),
          const SizedBox(width: AppSpacing.s),
          _NavButton(
            label: AccountStrings.balance,
            isSelected: selectedTab == AccountTab.balance,
            onTap: () => onTabChanged(AccountTab.balance),
          ),
          const SizedBox(width: AppSpacing.s),
          _NavButton(
            label: AccountStrings.friends,
            isSelected: selectedTab == AccountTab.friends,
            onTap: () => onTabChanged(AccountTab.friends),
          ),
          const SizedBox(width: AppSpacing.s),
          _NavButton(
            label: AccountStrings.historyRace,
            isSelected: selectedTab == AccountTab.historyRace,
            onTap: () => onTabChanged(AccountTab.historyRace),
          ),
        ],
      ),
    );
  }
}

class _NavColumn extends StatelessWidget {
  final AccountTab selectedTab;
  final void Function(AccountTab) onTabChanged;

  const _NavColumn({required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _NavButton(
            label: AccountStrings.personalInfo,
            isSelected: selectedTab == AccountTab.personalInfo,
            onTap: () => onTabChanged(AccountTab.personalInfo),
          ),
          const SizedBox(height: AppSpacing.s),
          _NavButton(
            label: AccountStrings.balance,
            isSelected: selectedTab == AccountTab.balance,
            onTap: () => onTabChanged(AccountTab.balance),
          ),
          const SizedBox(height: AppSpacing.s),
          _NavButton(
            label: AccountStrings.friends,
            isSelected: selectedTab == AccountTab.friends,
            onTap: () => onTabChanged(AccountTab.friends),
          ),
          const SizedBox(height: AppSpacing.s),
          _NavButton(
            label: AccountStrings.historyRace,
            isSelected: selectedTab == AccountTab.historyRace,
            onTap: () => onTabChanged(AccountTab.historyRace),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.9)
              : AppColors.panel.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(AppRadii.s),
          border: Border.all(
            color: isSelected ? AppColors.border : Colors.transparent,
            width: AppBorders.regular,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorContent({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.l),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
