abstract final class AccountStrings {
  // Screen titles
  static const String account = 'Account';
  static const String personalInfo = 'Personal info';
  static const String balance = 'Balance';
  static const String friends = 'Friends';
  static const String historyRace = 'History race';

  // Personal info form
  static const String save = 'Save';
  static const String fullName = 'Full name';
  static const String username = 'Username';
  static const String email = 'Email';
  static const String password = 'Password';

  // Balance
  static const String topUp = 'TOP UP';
  static const String withdraw = 'Withdraw';
  static const String withdrawal = 'Withdrawal';
  static const String deposit = 'Deposit';
  static const String successful = 'Successful';
  static const String declined = 'Declined';
  static const String queue = 'Queue';

  // Top up dialog
  static const String topUpTitle = 'Top up';
  static const String address = 'Address';
  static const String minimumDeposit = 'Minimum deposit';
  static const String minimumDepositValue = '10.00 USDT';

  // Withdraw dialog
  static const String withdrawTitle = 'Withdrawal';
  static const String amount = 'Amount';
  static const String available = 'Available:';
  static const String max = 'Max';
  static const String longPressToPaste = 'Long press to paste';
  static const String minimumAmount = 'Minimum 10.00';

  // Friends
  static const String listOfFriends = 'List of friends';
  static const String searchFriends = 'Search friends';

  // Networks
  static const String bsc = 'BSC';
  static const String bscFull = 'BNB Smart Chain (BEP20)';
  static const String trx = 'TRX';
  static const String trxFull = 'Tron (TRC20)';
  static const String eth = 'ETH';
  static const String ethFull = 'Ethereum (ERC20)';
}

abstract final class AccountSizes {
  // Responsive breakpoints
  static const double compactWidth = 600;
  static const double mediumWidth = 900;

  // Nav pill sizes
  static const double navPillMinWidth = 120;
  static const double navPillMaxWidth = 180;

  // Panel sizes
  static const double panelMinHeight = 200;
  static const double panelMaxWidth = 600;

  // Font sizes (relative multipliers for responsive text)
  static const double titleFontMultiplier = 0.035;
  static const double bodyFontMultiplier = 0.022;
  static const double smallFontMultiplier = 0.018;

  // Constraints
  static const double minTitleFont = 16;
  static const double maxTitleFont = 24;
  static const double minBodyFont = 12;
  static const double maxBodyFont = 18;
  static const double minSmallFont = 10;
  static const double maxSmallFont = 14;

  // Icon sizes
  static const double actionButtonSize = 50;
  static const double smallIconSize = 20;
}

abstract final class AccountAssets {
  static const String roadBackground = 'assets/backgrounds/road.jpg';
  static const String coinIcon = 'assets/icons/coin.png';
  static const String usdtIcon = 'assets/icons/usdt.png';
  static const String qrPlaceholder = 'assets/figma_design/resources/qr_placeholder.png';
}
