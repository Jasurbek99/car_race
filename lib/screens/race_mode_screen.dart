import 'package:flutter/material.dart';

class RaceModeScreen extends StatelessWidget {
  const RaceModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B11),
      body: Stack(
        children: [
          // Background gradient (vertical center line)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF090B11).withValues(alpha: 0.6),
                    const Color(0xFF0B1536).withValues(alpha: 0.99),
                  ],
                ),
              ),
            ),
          ),
          // Car image in background
          Positioned(
            right: -80,
            bottom: -100,
            child: Image.network(
              'https://www.figma.com/api/mcp/asset/cbd54c7c-977f-48e8-b545-57ed6d43a03d',
              width: 573,
              height: 573,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top bar with controls
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
                      // Back button
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E2D47),
                            border: Border.all(
                              color: const Color(0xFF0D467F),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Race mode title
                      const Text(
                        'Race mode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Unbounded',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      // Wallet display (VGX)
                      _WalletCard(
                        icon: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 23,
                        ),
                        label: 'VGX',
                        amount: '15145.45',
                      ),
                      const SizedBox(width: 12),
                      // Wallet display (USDT)
                      _WalletCard(
                        icon: Image.network(
                          'https://www.figma.com/api/mcp/asset/b49b9cc5-436f-427a-8f9d-2e867915cefb',
                          width: 23,
                          height: 23,
                        ),
                        label: 'USDT',
                        amount: '1254.12',
                      ),
                      const SizedBox(width: 12),
                      // Settings button
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E2D47),
                          border: Border.all(
                            color: const Color(0xFF0D467F),
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Race mode options
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left column: Training and Quick Race
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: _RaceCard(
                                  title: 'TRAINING',
                                  imageUrl: 'assets/images/training.png',
                                  isAsset: true,
                                  //'https://www.figma.com/api/mcp/asset/6d6cf3de-0932-442e-9288-d82730c2150e',
                                  participantCount: 1213,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: _RaceCard(
                                  title: 'QUICK RACE',
                                  isAsset: true,
                                  imageUrl: 'assets/images/quick_race.jpeg',
                                  // imageUrl:
                                  //     'https://www.figma.com/api/mcp/asset/ab17cc47-c3bd-4c61-8dc2-5bd39cc4b97e',
                                  participantCount: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Middle column: Online
                        Expanded(
                          flex: 1,
                          child: _RaceCard(
                            title: 'ONLINE',
                            isAsset: true,
                            imageUrl: 'assets/images/online.jpeg',
                            // imageUrl:
                            //     'https://www.figma.com/api/mcp/asset/9a4ee239-2a35-4cc7-9b46-544dcbf54308',
                            participantCount: 789,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Right column: P2P Race
                        Expanded(
                          flex: 1,
                          child: _RaceCard(
                            title: 'P2P RACE',
                            isAsset: true,
                            imageUrl: 'assets/images/p2p.jpeg',
                            //'https://www.figma.com/api/mcp/asset/992ddee2-d697-4af2-8245-c0299dade65a',
                            participantCount: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RaceCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int? participantCount;
  final bool isAsset;

  const _RaceCard({
    required this.title,
    required this.imageUrl,
    this.participantCount,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to race screen
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Starting $title race...')));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          border: Border.all(color: const Color(0xFF4860B7), width: 3),
          image: DecorationImage(
            image: isAsset
                ? AssetImage(imageUrl) as ImageProvider
                : NetworkImage(imageUrl) as ImageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Dark overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            // Title text
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Unbounded',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Participant count badge
            if (participantCount != null)
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E2D47).withValues(alpha: 0.8),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: const Color(0xFF4860B7),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.people, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        participantCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Unbounded',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final String amount;

  const _WalletCard({
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2D47),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: const Color(0xFF0D467F), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 20, height: 20, child: icon),
              const SizedBox(width: 6),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Unbounded',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.add, color: Color(0xFFFFCC00), size: 14),
            ],
          ),
        ],
      ),
    );
  }
}
