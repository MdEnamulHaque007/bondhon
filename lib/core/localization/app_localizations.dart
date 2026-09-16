import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  static const englishLocale = Locale('en');
  static const banglaLocale = Locale('bn');
  static const supportedLocales = [englishLocale, banglaLocale];

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static bool isSupported(String? languageCode) {
    return supportedLocales.any(
      (locale) => locale.languageCode == languageCode,
    );
  }

  bool get isBangla => locale.languageCode == banglaLocale.languageCode;

  String _text(String key) {
    return (_values[locale.languageCode] ?? _values['en']!)[key] ??
        _values['en']![key] ??
        key;
  }

  String get language => _text('language');
  String get english => _text('english');
  String get bangla => _text('bangla');
  String get back => _text('back');
  String get pageNotFound => _text('pageNotFound');
  String get loading => _text('loading');
  String get tagline => _text('tagline');
  String get welcomeDescription => _text('welcomeDescription');
  String get safetyBadge => _text('safetyBadge');
  String get journeyTitle => _text('journeyTitle');
  String get guestAccessDescription => _text('guestAccessDescription');
  String get enterNow => _text('enterNow');
  String get viewLoginStructure => _text('viewLoginStructure');
  String get guestModeInfo => _text('guestModeInfo');
  String get login => _text('login');
  String get loginSubtitle => _text('loginSubtitle');
  String get email => _text('email');
  String get password => _text('password');
  String get forgotPassword => _text('forgotPassword');
  String get loginComingSoon => _text('loginComingSoon');
  String get continueWithoutLogin => _text('continueWithoutLogin');
  String get viewRegisterStructure => _text('viewRegisterStructure');
  String get register => _text('register');
  String get registerSubtitle => _text('registerSubtitle');
  String get fullName => _text('fullName');
  String get registrationComingSoon => _text('registrationComingSoon');
  String get passwordRecovery => _text('passwordRecovery');
  String get passwordRecoverySubtitle => _text('passwordRecoverySubtitle');
  String get resetComingSoon => _text('resetComingSoon');
  String get guestUser => _text('guestUser');
  String get guestModeActive => _text('guestModeActive');
  String get home => _text('home');
  String get chats => _text('chats');
  String get rooms => _text('rooms');
  String get discover => _text('discover');
  String get profile => _text('profile');
  String get groups => _text('groups');
  String get chatRooms => _text('chatRooms');
  String get comingSoon => _text('comingSoon');
  String get chatsDescription => _text('chatsDescription');
  String get roomsDescription => _text('roomsDescription');
  String get discoverDescription => _text('discoverDescription');
  String get profileDescription => _text('profileDescription');
  String welcomeUser(String name) => '${_text('welcomePrefix')}, $name';

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _values = {
    'en': {
      'language': 'Language',
      'english': 'English',
      'bangla': 'বাংলা',
      'back': 'Go back',
      'pageNotFound': 'Page not found',
      'loading': 'Loading',
      'tagline': 'Build bonds through every conversation',
      'welcomeDescription':
          'Talk safely, find friends, and build your own community.',
      'safetyBadge': 'A safer social platform for Bangladesh',
      'journeyTitle': 'Start your Bondhon journey',
      'guestAccessDescription':
          'Enter directly without creating an account or signing in.',
      'enterNow': 'Enter now',
      'viewLoginStructure': 'View login structure',
      'guestModeInfo':
          'Guest Mode is active. Firebase authentication will be connected later.',
      'login': 'Log in',
      'loginSubtitle':
          'This feature will be enabled with Firebase in a future step.',
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot password?',
      'loginComingSoon': 'Login coming soon',
      'continueWithoutLogin': 'Continue without login',
      'viewRegisterStructure': 'View registration structure',
      'register': 'Create account',
      'registerSubtitle':
          'The registration UI is ready, but account creation is currently disabled.',
      'fullName': 'Full name',
      'registrationComingSoon': 'Registration coming soon',
      'passwordRecovery': 'Password recovery',
      'passwordRecoverySubtitle':
          'A reset link can be emailed after Firebase is enabled.',
      'resetComingSoon': 'Password reset coming soon',
      'guestUser': 'Guest User',
      'guestModeActive': 'Guest Mode is active—no login is required.',
      'welcomePrefix': 'Welcome',
      'home': 'Home',
      'chats': 'Chats',
      'rooms': 'Rooms',
      'discover': 'Discover',
      'profile': 'Profile',
      'groups': 'Groups',
      'chatRooms': 'Chat Rooms',
      'comingSoon': 'Coming soon',
      'chatsDescription': 'Your private and group conversations will appear here.',
      'roomsDescription': 'Join public chat and voice rooms from here.',
      'discoverDescription': 'Discover people, communities, and trending topics.',
      'profileDescription': 'Your guest profile and preferences will appear here.',
    },
    'bn': {
      'language': 'ভাষা',
      'english': 'English',
      'bangla': 'বাংলা',
      'back': 'পেছনে যান',
      'pageNotFound': 'পৃষ্ঠা খুঁজে পাওয়া যায়নি',
      'loading': 'লোড হচ্ছে',
      'tagline': 'কথায় কথায় গড়ে উঠুক বন্ধন',
      'welcomeDescription':
          'নিরাপদে কথা বলুন, বন্ধু খুঁজুন এবং নিজের কমিউনিটি গড়ে তুলুন।',
      'safetyBadge': 'বাংলাদেশের জন্য নিরাপদ সামাজিক প্ল্যাটফর্ম',
      'journeyTitle': 'আপনার বন্ধনের যাত্রা শুরু করুন',
      'guestAccessDescription':
          'কোনো অ্যাকাউন্ট বা লগইন ছাড়াই সরাসরি প্রবেশ করুন।',
      'enterNow': 'এখনই প্রবেশ করুন',
      'viewLoginStructure': 'Login structure দেখুন',
      'guestModeInfo':
          'Guest Mode চালু আছে। Authentication পরে Firebase-এর সঙ্গে যুক্ত করা হবে।',
      'login': 'লগইন',
      'loginSubtitle':
          'এই সুবিধাটি ভবিষ্যতে Firebase-এর সঙ্গে সক্রিয় হবে।',
      'email': 'ইমেইল',
      'password': 'পাসওয়ার্ড',
      'forgotPassword': 'পাসওয়ার্ড ভুলে গেছেন?',
      'loginComingSoon': 'লগইন শিগগিরই চালু হবে',
      'continueWithoutLogin': 'লগইন ছাড়াই প্রবেশ করুন',
      'viewRegisterStructure': 'নতুন অ্যাকাউন্টের কাঠামো দেখুন',
      'register': 'নতুন অ্যাকাউন্ট',
      'registerSubtitle':
          'Registration UI প্রস্তুত আছে, তবে account তৈরি এখন বন্ধ।',
      'fullName': 'পূর্ণ নাম',
      'registrationComingSoon': 'Registration শিগগিরই চালু হবে',
      'passwordRecovery': 'পাসওয়ার্ড পুনরুদ্ধার',
      'passwordRecoverySubtitle':
          'Firebase চালু হলে ইমেইলে reset link পাঠানো যাবে।',
      'resetComingSoon': 'Reset সুবিধা শিগগিরই চালু হবে',
      'guestUser': 'অতিথি ব্যবহারকারী',
      'guestModeActive': 'Guest Mode চালু আছে—কোনো লগইন প্রয়োজন নেই।',
      'welcomePrefix': 'স্বাগতম',
      'home': 'হোম',
      'chats': 'চ্যাট',
      'rooms': 'রুম',
      'discover': 'খুঁজুন',
      'profile': 'প্রোফাইল',
      'groups': 'গ্রুপ',
      'chatRooms': 'চ্যাট রুম',
      'comingSoon': 'শিগগিরই আসছে',
      'chatsDescription': 'আপনার ব্যক্তিগত ও গ্রুপ কথোপকথন এখানে দেখা যাবে।',
      'roomsDescription': 'এখান থেকে public chat ও voice room-এ যোগ দিন।',
      'discoverDescription': 'মানুষ, কমিউনিটি ও জনপ্রিয় বিষয় খুঁজে নিন।',
      'profileDescription': 'আপনার guest profile ও পছন্দগুলো এখানে থাকবে।',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.isSupported(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
