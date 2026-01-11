import 'package:flutter/material.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/user_profile.dart';

class PersonalInfoPanelNew extends StatelessWidget {
  final UserProfile profile;

  const PersonalInfoPanelNew({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadii.m),
        border: Border.all(color: AppColors.border, width: AppBorders.regular),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField('Name', profile.name),
            const SizedBox(height: AppSpacing.m),
            _buildField('Email', profile.email),
            const SizedBox(height: AppSpacing.m),
            _buildField('Phone', profile.phone),
            const SizedBox(height: AppSpacing.m),
            _buildField('Country', profile.country),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.panelAlt.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadii.s),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
