import 'package:flutter/material.dart';

import '../../../ui/style/app_style.dart';
import '../account_constants.dart';

class Friend {
  final String fullName;
  final String username;
  final String email;

  const Friend({
    required this.fullName,
    required this.username,
    required this.email,
  });
}

class FriendsPanel extends StatefulWidget {
  const FriendsPanel({super.key});

  @override
  State<FriendsPanel> createState() => _FriendsPanelState();
}

class _FriendsPanelState extends State<FriendsPanel> {
  int _selectedTabIndex = 0;

  static const _friends = [
    Friend(
      fullName: 'John Doe Alcares',
      username: 'Turbo',
      email: 'Johndoe@gmail.com',
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
          _buildTabs(),
          const SizedBox(height: AppSpacing.l),
          Expanded(
            child: _selectedTabIndex == 0
                ? const _FriendsList(friends: _friends)
                : const _SearchFriends(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            text: AccountStrings.listOfFriends,
            isActive: _selectedTabIndex == 0,
            onTap: () => setState(() => _selectedTabIndex = 0),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: _TabButton(
            text: AccountStrings.searchFriends,
            isActive: _selectedTabIndex == 1,
            onTap: () => setState(() => _selectedTabIndex = 1),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(color: AppColors.border, width: AppBorders.regular),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FriendsList extends StatelessWidget {
  final List<Friend> friends;

  const _FriendsList({required this.friends});

  @override
  Widget build(BuildContext context) {
    if (friends.isEmpty) {
      return const Center(
        child: Text(
          'No friends yet',
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
      );
    }

    return ListView.separated(
      itemCount: friends.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.m),
      itemBuilder: (context, index) {
        return _FriendCard(friend: friends[index]);
      },
    );
  }
}

class _FriendCard extends StatelessWidget {
  final Friend friend;

  const _FriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(label: AccountStrings.fullName, value: friend.fullName),
        const SizedBox(height: AppSpacing.m),
        _InfoRow(label: AccountStrings.username, value: friend.username),
        const SizedBox(height: AppSpacing.m),
        _InfoRow(label: AccountStrings.email, value: friend.email),
        const SizedBox(height: AppSpacing.m),
        _InfoRow(label: AccountStrings.password, value: '****************'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SearchFriends extends StatelessWidget {
  const _SearchFriends();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            children: const [
              Icon(Icons.search, color: AppColors.textMuted, size: 18),
              SizedBox(width: AppSpacing.s),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search by username...',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Search for friends by username',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
