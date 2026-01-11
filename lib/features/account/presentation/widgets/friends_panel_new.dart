import 'package:flutter/material.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/friend.dart';

class FriendsPanelNew extends StatelessWidget {
  final List<Friend> friends;

  const FriendsPanelNew({super.key, required this.friends});

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
            'Friends',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Expanded(
            child: friends.isEmpty
                ? const Center(
                    child: Text(
                      'No friends yet',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.separated(
                    itemCount: friends.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s),
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return _FriendItem(friend: friend);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FriendItem extends StatelessWidget {
  final Friend friend;

  const _FriendItem({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.panelAlt.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadii.s),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary,
                child: Text(
                  friend.name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (friend.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.positive,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.panel, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Level ${friend.level}',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: friend.isOnline
                  ? AppColors.positive.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              friend.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                color: friend.isOnline ? AppColors.positive : Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
