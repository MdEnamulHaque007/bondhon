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
  String get guestAccount => _text('guestAccount');
  String get personalInformation => _text('personalInformation');
  String get editProfile => _text('editProfile');
  String get cancel => _text('cancel');
  String get username => _text('username');
  String get usernameHelp => _text('usernameHelp');
  String get gender => _text('gender');
  String get male => _text('male');
  String get female => _text('female');
  String get preferNotToSay => _text('preferNotToSay');
  String get country => _text('country');
  String get bio => _text('bio');
  String get requiredField => _text('requiredField');
  String get saveChanges => _text('saveChanges');
  String get profileSaved => _text('profileSaved');
  String get languageSettingsInfo => _text('languageSettingsInfo');
  String get exitGuestMode => _text('exitGuestMode');
  String get exitGuestModeInfo => _text('exitGuestModeInfo');
  String get publicChatRooms => _text('publicChatRooms');
  String get publicChatRoomsDescription => _text('publicChatRoomsDescription');
  String get searchRooms => _text('searchRooms');
  String get clearSearch => _text('clearSearch');
  String get all => _text('all');
  String get friendship => _text('friendship');
  String get regional => _text('regional');
  String get education => _text('education');
  String get entertainment => _text('entertainment');
  String get noRoomsFound => _text('noRoomsFound');
  String get live => _text('live');
  String get viewRoom => _text('viewRoom');
  String get roomNotFound => _text('roomNotFound');
  String get backToRooms => _text('backToRooms');
  String get joinAsGuest => _text('joinAsGuest');
  String get joined => _text('joined');
  String get typeMessage => _text('typeMessage');
  String get send => _text('send');
  String get joinToSendMessages => _text('joinToSendMessages');
  String get privateChats => _text('privateChats');
  String get privateChatsDescription => _text('privateChatsDescription');
  String get searchConversations => _text('searchConversations');
  String get noConversationsFound => _text('noConversationsFound');
  String get online => _text('online');
  String get offline => _text('offline');
  String get conversationNotFound => _text('conversationNotFound');
  String get backToChats => _text('backToChats');
  String get startConversation => _text('startConversation');
  String get conversationInfo => _text('conversationInfo');
  String get profileComingSoon => _text('profileComingSoon');
  String get read => _text('read');
  String get sent => _text('sent');
  String get discoverPeople => _text('discoverPeople');
  String get discoverPeopleDescription => _text('discoverPeopleDescription');
  String get searchPeople => _text('searchPeople');
  String get onlineNow => _text('onlineNow');
  String get nearby => _text('nearby');
  String get commonInterests => _text('commonInterests');
  String get noPeopleFound => _text('noPeopleFound');
  String get viewProfile => _text('viewProfile');
  String get addFriend => _text('addFriend');
  String get requestSent => _text('requestSent');
  String get message => _text('message');
  String get userNotFound => _text('userNotFound');
  String get backToDiscover => _text('backToDiscover');
  String get about => _text('about');
  String get interests => _text('interests');
  String get friendsAndRequests => _text('friendsAndRequests');
  String get searchFriends => _text('searchFriends');
  String get friends => _text('friends');
  String get incoming => _text('incoming');
  String get outgoing => _text('outgoing');
  String get accept => _text('accept');
  String get reject => _text('reject');
  String get cancelRequest => _text('cancelRequest');
  String get noFriendsFound => _text('noFriendsFound');
  String get noIncomingRequests => _text('noIncomingRequests');
  String get noOutgoingRequests => _text('noOutgoingRequests');
  String get friendRequestAccepted => _text('friendRequestAccepted');
  String get friendRequestRejected => _text('friendRequestRejected');
  String get friendRequestCancelled => _text('friendRequestCancelled');
  String get reportUser => _text('reportUser');
  String get reportMessage => _text('reportMessage');
  String get selectReportReason => _text('selectReportReason');
  String get harassment => _text('harassment');
  String get spam => _text('spam');
  String get hateSpeech => _text('hateSpeech');
  String get inappropriateContent => _text('inappropriateContent');
  String get other => _text('other');
  String get submitReport => _text('submitReport');
  String get reportConfirmation => _text('reportConfirmation');
  String get submit => _text('submit');
  String get reportSubmitted => _text('reportSubmitted');
  String get blockUser => _text('blockUser');
  String get block => _text('block');
  String get userBlocked => _text('userBlocked');
  String get blockedUsers => _text('blockedUsers');
  String get blockedUsersInfo => _text('blockedUsersInfo');
  String get noBlockedUsers => _text('noBlockedUsers');
  String get unblock => _text('unblock');
  String get userUnblocked => _text('userUnblocked');
  String get notifications => _text('notifications');
  String get unread => _text('unread');
  String get markAllAsRead => _text('markAllAsRead');
  String get clearAll => _text('clearAll');
  String get clearNotifications => _text('clearNotifications');
  String get clearNotificationsConfirmation =>
      _text('clearNotificationsConfirmation');
  String get noNotifications => _text('noNotifications');
  String get noUnreadNotifications => _text('noUnreadNotifications');
  String get deleteNotification => _text('deleteNotification');
  String blockUserConfirmation(String name) =>
      _text('blockUserConfirmation').replaceAll('{name}', name);
  String mutualFriendCount(int count) => '$count ${_text('mutualFriends')}';
  String memberCount(int count) => '$count ${_text('members')}';
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
      'guestAccount': 'Guest account',
      'personalInformation': 'Personal information',
      'editProfile': 'Edit profile',
      'cancel': 'Cancel',
      'username': 'Username',
      'usernameHelp': 'Use 3–20 letters, numbers, or underscores.',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'preferNotToSay': 'Prefer not to say',
      'country': 'Country',
      'bio': 'Bio',
      'requiredField': 'This field is required.',
      'saveChanges': 'Save changes',
      'profileSaved': 'Profile saved on this device.',
      'languageSettingsInfo': 'Use the language selector in the app bar.',
      'exitGuestMode': 'Exit Guest Mode',
      'exitGuestModeInfo': 'Return to the welcome screen without deleting your profile.',
      'publicChatRooms': 'Public Chat Rooms',
      'publicChatRoomsDescription':
          'Find a community, preview conversations, and join instantly as a guest.',
      'searchRooms': 'Search rooms',
      'clearSearch': 'Clear search',
      'all': 'All',
      'friendship': 'Friendship',
      'regional': 'Regional',
      'education': 'Education',
      'entertainment': 'Entertainment',
      'noRoomsFound': 'No rooms match your search.',
      'live': 'Live',
      'viewRoom': 'View room',
      'members': 'members',
      'roomNotFound': 'Room not found.',
      'backToRooms': 'Back to rooms',
      'joinAsGuest': 'Join as guest',
      'joined': 'Joined',
      'typeMessage': 'Type a message',
      'send': 'Send',
      'joinToSendMessages': 'Join this room as a guest to send messages.',
      'privateChats': 'Private Chats',
      'privateChatsDescription':
          'Continue one-to-one conversations and find people by name or username.',
      'searchConversations': 'Search conversations',
      'noConversationsFound': 'No conversations match your search.',
      'online': 'Online',
      'offline': 'Offline',
      'conversationNotFound': 'Conversation not found.',
      'backToChats': 'Back to chats',
      'startConversation': 'Send a message to start this conversation.',
      'conversationInfo': 'Conversation information',
      'profileComingSoon': 'User profile details will be connected in a future step.',
      'read': 'Read',
      'sent': 'Sent',
      'discoverPeople': 'Discover People',
      'discoverPeopleDescription':
          'Find people, explore shared interests, and build new friendships.',
      'searchPeople': 'Search people, location, or interests',
      'onlineNow': 'Online now',
      'nearby': 'Nearby',
      'commonInterests': 'Common interests',
      'noPeopleFound': 'No people match your search.',
      'viewProfile': 'View profile',
      'addFriend': 'Add friend',
      'requestSent': 'Request sent',
      'message': 'Message',
      'mutualFriends': 'mutual friends',
      'userNotFound': 'User not found.',
      'backToDiscover': 'Back to discover',
      'about': 'About',
      'interests': 'Interests',
      'friendsAndRequests': 'Friends & Requests',
      'searchFriends': 'Search friends or requests',
      'friends': 'Friends',
      'incoming': 'Incoming',
      'outgoing': 'Outgoing',
      'accept': 'Accept',
      'reject': 'Reject',
      'cancelRequest': 'Cancel request',
      'noFriendsFound': 'No friends match your search.',
      'noIncomingRequests': 'No incoming friend requests.',
      'noOutgoingRequests': 'No outgoing friend requests.',
      'friendRequestAccepted': 'Friend request accepted.',
      'friendRequestRejected': 'Friend request rejected.',
      'friendRequestCancelled': 'Friend request cancelled.',
      'reportUser': 'Report user',
      'reportMessage': 'Report message',
      'selectReportReason': 'Why are you reporting this?',
      'harassment': 'Harassment or bullying',
      'spam': 'Spam or misleading content',
      'hateSpeech': 'Hate speech',
      'inappropriateContent': 'Inappropriate content',
      'other': 'Other',
      'submitReport': 'Submit report?',
      'reportConfirmation':
          'The report will be saved for moderation review. The reported person will not be notified.',
      'submit': 'Submit',
      'reportSubmitted': 'Report submitted for review.',
      'blockUser': 'Block user',
      'block': 'Block',
      'blockUserConfirmation':
          'Block {name}? They will be hidden from your blocked interactions.',
      'userBlocked': 'User blocked.',
      'blockedUsers': 'Blocked users',
      'blockedUsersInfo': 'Review and unblock people you have blocked.',
      'noBlockedUsers': 'You have not blocked anyone.',
      'unblock': 'Unblock',
      'userUnblocked': 'User unblocked.',
      'notifications': 'Notifications',
      'unread': 'Unread',
      'markAllAsRead': 'Mark all as read',
      'clearAll': 'Clear all',
      'clearNotifications': 'Clear notifications?',
      'clearNotificationsConfirmation':
          'This will permanently remove all notifications from this device.',
      'noNotifications': 'You have no notifications.',
      'noUnreadNotifications': 'You have no unread notifications.',
      'deleteNotification': 'Delete notification',
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
      'guestAccount': 'অতিথি অ্যাকাউন্ট',
      'personalInformation': 'ব্যক্তিগত তথ্য',
      'editProfile': 'প্রোফাইল সম্পাদনা',
      'cancel': 'বাতিল',
      'username': 'ইউজারনেম',
      'usernameHelp': '৩–২০টি ইংরেজি অক্ষর, সংখ্যা বা আন্ডারস্কোর ব্যবহার করুন।',
      'gender': 'লিঙ্গ',
      'male': 'পুরুষ',
      'female': 'নারী',
      'preferNotToSay': 'উল্লেখ করতে চাই না',
      'country': 'দেশ',
      'bio': 'পরিচিতি',
      'requiredField': 'এই তথ্যটি আবশ্যক।',
      'saveChanges': 'পরিবর্তন সংরক্ষণ করুন',
      'profileSaved': 'এই ডিভাইসে প্রোফাইল সংরক্ষিত হয়েছে।',
      'languageSettingsInfo': 'App bar-এর language selector ব্যবহার করুন।',
      'exitGuestMode': 'Guest Mode থেকে বের হন',
      'exitGuestModeInfo': 'প্রোফাইল মুছে না ফেলে welcome screen-এ ফিরে যান।',
      'publicChatRooms': 'পাবলিক চ্যাট রুম',
      'publicChatRoomsDescription':
          'কমিউনিটি খুঁজুন, কথোপকথন দেখুন এবং অতিথি হিসেবে সরাসরি যোগ দিন।',
      'searchRooms': 'রুম খুঁজুন',
      'clearSearch': 'অনুসন্ধান মুছুন',
      'all': 'সব',
      'friendship': 'বন্ধুত্ব',
      'regional': 'আঞ্চলিক',
      'education': 'শিক্ষা',
      'entertainment': 'বিনোদন',
      'noRoomsFound': 'আপনার অনুসন্ধানের সঙ্গে কোনো রুম পাওয়া যায়নি।',
      'live': 'লাইভ',
      'viewRoom': 'রুম দেখুন',
      'members': 'সদস্য',
      'roomNotFound': 'রুমটি পাওয়া যায়নি।',
      'backToRooms': 'রুম তালিকায় ফিরুন',
      'joinAsGuest': 'অতিথি হিসেবে যোগ দিন',
      'joined': 'যোগ দিয়েছেন',
      'typeMessage': 'মেসেজ লিখুন',
      'send': 'পাঠান',
      'joinToSendMessages': 'মেসেজ পাঠাতে অতিথি হিসেবে এই রুমে যোগ দিন।',
      'privateChats': 'ব্যক্তিগত চ্যাট',
      'privateChatsDescription':
          'একান্ত কথোপকথন চালিয়ে যান এবং নাম বা ইউজারনেম দিয়ে মানুষ খুঁজুন।',
      'searchConversations': 'কথোপকথন খুঁজুন',
      'noConversationsFound': 'আপনার অনুসন্ধানের সঙ্গে কোনো কথোপকথন পাওয়া যায়নি।',
      'online': 'অনলাইন',
      'offline': 'অফলাইন',
      'conversationNotFound': 'কথোপকথনটি পাওয়া যায়নি।',
      'backToChats': 'চ্যাট তালিকায় ফিরুন',
      'startConversation': 'কথোপকথন শুরু করতে একটি মেসেজ পাঠান।',
      'conversationInfo': 'কথোপকথনের তথ্য',
      'profileComingSoon': 'পরবর্তী ধাপে ব্যবহারকারীর প্রোফাইল যুক্ত করা হবে।',
      'read': 'পড়া হয়েছে',
      'sent': 'পাঠানো হয়েছে',
      'discoverPeople': 'মানুষ খুঁজুন',
      'discoverPeopleDescription':
          'মানুষ খুঁজুন, মিল থাকা আগ্রহ দেখুন এবং নতুন বন্ধুত্ব গড়ে তুলুন।',
      'searchPeople': 'মানুষ, স্থান বা আগ্রহ খুঁজুন',
      'onlineNow': 'এখন অনলাইনে',
      'nearby': 'কাছাকাছি',
      'commonInterests': 'একই আগ্রহ',
      'noPeopleFound': 'আপনার অনুসন্ধানের সঙ্গে কাউকে পাওয়া যায়নি।',
      'viewProfile': 'প্রোফাইল দেখুন',
      'addFriend': 'বন্ধু যোগ করুন',
      'requestSent': 'অনুরোধ পাঠানো হয়েছে',
      'message': 'মেসেজ',
      'mutualFriends': 'জন পারস্পরিক বন্ধু',
      'userNotFound': 'ব্যবহারকারীকে পাওয়া যায়নি।',
      'backToDiscover': 'Discover-এ ফিরুন',
      'about': 'পরিচিতি',
      'interests': 'আগ্রহ',
      'friendsAndRequests': 'বন্ধু ও অনুরোধ',
      'searchFriends': 'বন্ধু বা অনুরোধ খুঁজুন',
      'friends': 'বন্ধু',
      'incoming': 'আসা অনুরোধ',
      'outgoing': 'পাঠানো অনুরোধ',
      'accept': 'গ্রহণ করুন',
      'reject': 'প্রত্যাখ্যান করুন',
      'cancelRequest': 'অনুরোধ বাতিল করুন',
      'noFriendsFound': 'আপনার অনুসন্ধানের সঙ্গে কোনো বন্ধু পাওয়া যায়নি।',
      'noIncomingRequests': 'কোনো নতুন বন্ধুত্বের অনুরোধ নেই।',
      'noOutgoingRequests': 'কোনো পাঠানো বন্ধুত্বের অনুরোধ নেই।',
      'friendRequestAccepted': 'বন্ধুত্বের অনুরোধ গ্রহণ করা হয়েছে।',
      'friendRequestRejected': 'বন্ধুত্বের অনুরোধ প্রত্যাখ্যান করা হয়েছে।',
      'friendRequestCancelled': 'বন্ধুত্বের অনুরোধ বাতিল করা হয়েছে।',
      'reportUser': 'ব্যবহারকারীকে রিপোর্ট করুন',
      'reportMessage': 'মেসেজ রিপোর্ট করুন',
      'selectReportReason': 'কেন রিপোর্ট করছেন?',
      'harassment': 'হয়রানি বা বুলিং',
      'spam': 'স্প্যাম বা বিভ্রান্তিকর কনটেন্ট',
      'hateSpeech': 'ঘৃণামূলক বক্তব্য',
      'inappropriateContent': 'অনুপযুক্ত কনটেন্ট',
      'other': 'অন্যান্য',
      'submitReport': 'রিপোর্ট জমা দেবেন?',
      'reportConfirmation':
          'রিপোর্টটি moderation review-এর জন্য সংরক্ষিত হবে। রিপোর্ট করা ব্যক্তিকে জানানো হবে না।',
      'submit': 'জমা দিন',
      'reportSubmitted': 'রিপোর্ট পর্যালোচনার জন্য জমা হয়েছে।',
      'blockUser': 'ব্যবহারকারীকে ব্লক করুন',
      'block': 'ব্লক করুন',
      'blockUserConfirmation':
          'আপনি কি {name}-কে ব্লক করতে চান? আপনার blocked interaction থেকে তাকে লুকানো হবে।',
      'userBlocked': 'ব্যবহারকারীকে ব্লক করা হয়েছে।',
      'blockedUsers': 'ব্লক করা ব্যবহারকারী',
      'blockedUsersInfo': 'ব্লক করা ব্যক্তিদের দেখুন এবং unblock করুন।',
      'noBlockedUsers': 'আপনি কাউকে ব্লক করেননি।',
      'unblock': 'আনব্লক করুন',
      'userUnblocked': 'ব্যবহারকারীকে আনব্লক করা হয়েছে।',
      'notifications': 'নোটিফিকেশন',
      'unread': 'না-পড়া',
      'markAllAsRead': 'সব পড়া হয়েছে হিসেবে চিহ্নিত করুন',
      'clearAll': 'সব মুছুন',
      'clearNotifications': 'সব নোটিফিকেশন মুছবেন?',
      'clearNotificationsConfirmation':
          'এতে এই ডিভাইস থেকে সব নোটিফিকেশন স্থায়ীভাবে মুছে যাবে।',
      'noNotifications': 'আপনার কোনো নোটিফিকেশন নেই।',
      'noUnreadNotifications': 'আপনার কোনো না-পড়া নোটিফিকেশন নেই।',
      'deleteNotification': 'নোটিফিকেশন মুছুন',
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
