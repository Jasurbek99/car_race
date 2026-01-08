import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themedText = GoogleFonts.unboundedTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    return Theme(
      data: Theme.of(context).copyWith(textTheme: themedText),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/backgrounds/road.jpg'),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.65),
                ],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const _TopBar(),
                            const SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                _NavColumn(),
                                SizedBox(width: 24),
                                Expanded(child: _FriendsPanel()),
                              ],
                            ),
                          ],
                        ),
                      ),
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
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _BorderedIconButton(icon: Icons.arrow_back_ios_new_rounded),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Account',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
          ),
        ),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              _TokenChip(
                icon: Icons.currency_bitcoin_rounded,
                value: '15145.45',
                background: Color(0xFF222447),
                iconBackground: Color(0xFF6362D9),
              ),
              _TokenChip(
                icon: Icons.token_rounded,
                value: '1254.12',
                background: Color(0xFF222447),
                iconBackground: Color(0xFF3AC182),
              ),
              _BorderedIconButton(icon: Icons.settings_outlined),
            ],
          ),
        ),
      ],
    );
  }
}

class _TokenChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color background;
  final Color iconBackground;

  const _TokenChip({
    required this.icon,
    required this.value,
    required this.background,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: background.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconBackground,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.add, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}

class _BorderedIconButton extends StatelessWidget {
  final IconData icon;

  const _BorderedIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF222447).withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}

class _NavColumn extends StatelessWidget {
  const _NavColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _NavPill(text: 'Personal info'),
        SizedBox(height: 18),
        _NavPill(text: 'Balance'),
        SizedBox(height: 18),
        _NavPill(text: 'Friends', isActive: true),
        SizedBox(height: 18),
        _NavPill(text: 'History race'),
      ],
    );
  }
}

class _NavPill extends StatelessWidget {
  final String text;
  final bool isActive;

  const _NavPill({required this.text, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = isActive ? const Color(0xFF5C5BD6) : const Color(0xFF26263D);
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}

class _FriendsPanel extends StatelessWidget {
  const _FriendsPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF26263D).withOpacity(0.95),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: _TabPill(
                  text: 'List of friends',
                  isActive: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _TabPill(
                  text: 'Search friends',
                  isActive: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _InfoRow(label: 'Full name', value: 'John Doe Alcares'),
                  SizedBox(height: 28),
                  _InfoRow(label: 'Username', value: 'Turbo'),
                  SizedBox(height: 28),
                  _InfoRow(label: 'Email', value: 'Johndoe@gmail.com'),
                  SizedBox(height: 28),
                  _InfoRow(label: 'Password', value: '****************'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String text;
  final bool isActive;

  const _TabPill({required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5C5BD6) : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                color: const Color(0xFFBDBCC9),
                fontWeight: FontWeight.w600,
              ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
