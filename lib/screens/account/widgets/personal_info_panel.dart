import 'package:flutter/material.dart';

import '../../../ui/style/app_style.dart';
import '../account_constants.dart';

class PersonalInfoPanel extends StatefulWidget {
  const PersonalInfoPanel({super.key});

  @override
  State<PersonalInfoPanel> createState() => _PersonalInfoPanelState();
}

class _PersonalInfoPanelState extends State<PersonalInfoPanel> {
  final _fullNameController = TextEditingController(text: 'John Doe Alcares');
  final _usernameController = TextEditingController(text: 'Turbo');
  final _emailController = TextEditingController(text: 'Johndoe@gmail.com');
  final _passwordController = TextEditingController(text: 'password123456');

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          _buildHeader(),
          const SizedBox(height: AppSpacing.l),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _FormField(
                    label: AccountStrings.fullName,
                    controller: _fullNameController,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  _FormField(
                    label: AccountStrings.username,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  _FormField(
                    label: AccountStrings.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  _FormField(
                    label: AccountStrings.password,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              AccountStrings.personalInfo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _onSave,
          child: Text(
            AccountStrings.save,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _onSave() {
    // Handle save action
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  const _FormField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 400;
        if (isWide) {
          return Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(child: _buildInput()),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _buildInput(),
          ],
        );
      },
    );
  }

  Widget _buildInput() {
    return Container(
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
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
