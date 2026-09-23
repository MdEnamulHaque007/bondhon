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
  String get socialFeed => _text('socialFeed');
  String get refreshFeed => _text('refreshFeed');
  String get post => _text('post');
  String get postCreated => _text('postCreated');
  String get whatsOnYourMind => _text('whatsOnYourMind');
  String get publicPrivacy => _text('publicPrivacy');
  String get friendsPrivacy => _text('friendsPrivacy');
  String get onlyMePrivacy => _text('onlyMePrivacy');
  String get like => _text('like');
  String get comments => _text('comments');
  String get comment => _text('comment');
  String get writeComment => _text('writeComment');
  String get noComments => _text('noComments');
  String get postDetails => _text('postDetails');
  String get postNotFound => _text('postNotFound');
  String get reportPost => _text('reportPost');
  String get justNow => _text('justNow');
  String minutesAgo(int count) => _text('minutesAgo').replaceAll('{count}', '$count');
  String hoursAgo(int count) => _text('hoursAgo').replaceAll('{count}', '$count');
  String daysAgo(int count) => _text('daysAgo').replaceAll('{count}', '$count');
  String get groupsDescription => _text('groupsDescription');
  String get createGroup => _text('createGroup');
  String get groupName => _text('groupName');
  String get groupDescription => _text('groupDescription');
  String get publicGroup => _text('publicGroup');
  String get privateGroup => _text('privateGroup');
  String get publicGroupInfo => _text('publicGroupInfo');
  String get privateGroupInfo => _text('privateGroupInfo');
  String get searchGroups => _text('searchGroups');
  String get noGroupsFound => _text('noGroupsFound');
  String get groupNotFound => _text('groupNotFound');
  String get rolesPreview => _text('rolesPreview');
  String get owner => _text('owner');
  String get admin => _text('admin');
  String get member => _text('member');
  String get memberPreview => _text('memberPreview');
  String get copyInviteLink => _text('copyInviteLink');
  String get inviteLinkCopied => _text('inviteLinkCopied');
  String get leaveGroup => _text('leaveGroup');
  String get adminOnlyMessaging => _text('adminOnlyMessaging');
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
  String get adminDemo => _text('adminDemo');
  String get adminDemoInfo => _text('adminDemoInfo');
  String get adminDashboard => _text('adminDashboard');
  String get adminDemoBanner => _text('adminDemoBanner');
  String get adminLastUpdated => _text('adminLastUpdated');
  String get totalUsers => _text('totalUsers');
  String get dailyActiveUsers => _text('dailyActiveUsers');
  String get messagesSent => _text('messagesSent');
  String get activeRooms => _text('activeRooms');
  String get openReports => _text('openReports');
  String get adminUsers => _text('adminUsers');
  String get adminReports => _text('adminReports');
  String get adminContent => _text('adminContent');
  String get adminSearchUsers => _text('adminSearchUsers');
  String get adminWarn => _text('adminWarn');
  String get adminSuspend => _text('adminSuspend');
  String get adminBan => _text('adminBan');
  String get adminUnban => _text('adminUnban');
  String get adminActive => _text('adminActive');
  String get adminWarned => _text('adminWarned');
  String get adminSuspended => _text('adminSuspended');
  String get adminBanned => _text('adminBanned');
  String get adminMarkReviewed => _text('adminMarkReviewed');
  String get adminDismiss => _text('adminDismiss');
  String get adminOpen => _text('adminOpen');
  String get adminReviewed => _text('adminReviewed');
  String get adminDismissed => _text('adminDismissed');
  String get adminRemove => _text('adminRemove');
  String get adminKeep => _text('adminKeep');

  String get privacySettings => _text('privacySettings');
  String get lastSeenVisibility => _text('lastSeenVisibility');
  String get lastSeenVisibilityInfo => _text('lastSeenVisibilityInfo');
  String get profilePhotoVisibility => _text('profilePhotoVisibility');
  String get profilePhotoVisibilityInfo => _text('profilePhotoVisibilityInfo');
  String get whoCanMessage => _text('whoCanMessage');
  String get whoCanMessageInfo => _text('whoCanMessageInfo');
  String get whoCanAddToGroup => _text('whoCanAddToGroup');
  String get whoCanAddToGroupInfo => _text('whoCanAddToGroupInfo');
  String get privacyLocalOnlyInfo => _text('privacyLocalOnlyInfo');
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
      'socialFeed': 'Social Feed',
      'refreshFeed': 'Refresh feed',
      'post': 'Post',
      'postCreated': 'Post created locally.',
      'whatsOnYourMind': "What's on your mind?",
      'publicPrivacy': 'Public',
      'friendsPrivacy': 'Friends',
      'onlyMePrivacy': 'Only Me',
      'like': 'Like',
      'comments': 'Comments',
      'comment': 'Comment',
      'writeComment': 'Write a comment',
      'noComments': 'No comments yet.',
      'postDetails': 'Post details',
      'postNotFound': 'Post not found.',
      'reportPost': 'Report post',
      'justNow': 'Just now',
      'minutesAgo': '{count}m ago',
      'hoursAgo': '{count}h ago',
      'daysAgo': '{count}d ago',
      'groupsDescription': 'Discover public and private communities and chat as a guest.',
      'createGroup': 'Create group',
      'groupName': 'Group name',
      'groupDescription': 'Group description',
      'publicGroup': 'Public group',
      'privateGroup': 'Private group',
      'publicGroupInfo': 'Anyone can discover and join this group.',
      'privateGroupInfo': 'Keep this group visible only to invited members.',
      'searchGroups': 'Search groups',
      'noGroupsFound': 'No groups match your search.',
      'groupNotFound': 'Group not found.',
      'rolesPreview': 'Roles',
      'owner': 'Owner',
      'admin': 'Admin',
      'member': 'Member',
      'memberPreview': 'Member preview',
      'copyInviteLink': 'Copy invite link',
      'inviteLinkCopied': 'Dummy invite link copied.',
      'leaveGroup': 'Leave group',
      'adminOnlyMessaging': 'Only group admins can send messages in this group.',
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
      'publicChatRoomsDescription': 'Join open rooms and chat as a guest.',
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
      'roomNotFound': 'Room not found.',
      'backToRooms': 'Back to rooms',
      'joinAsGuest': 'Join as Guest',
      'joined': 'Joined',
      'typeMessage': 'Type a message',
      'send': 'Send',
      'joinToSendMessages': 'Join the room to send messages.',
      'privateChats': 'Private chats',
      'privateChatsDescription': 'Your one-to-one conversations.',
      'searchConversations': 'Search conversations',
      'noConversationsFound': 'No conversations found.',
      'online': 'Online',
      'offline': 'Offline',
      'conversationNotFound': 'Conversation not found.',
      'backToChats': 'Back to chats',
      'startConversation': 'Start conversation',
      'conversationInfo': 'Conversation info',
      'profileComingSoon': 'Profile details coming soon.',
      'read': 'Read',
      'sent': 'Sent',
      'discoverPeople': 'Discover people',
      'discoverPeopleDescription': 'Find friends with shared interests.',
      'searchPeople': 'Search people',
      'onlineNow': 'Online now',
      'nearby': 'Nearby',
      'commonInterests': 'Common interests',
      'noPeopleFound': 'No people found.',
      'viewProfile': 'View profile',
      'addFriend': 'Add friend',
      'requestSent': 'Request sent',
      'message': 'Message',
      'userNotFound': 'User not found.',
      'backToDiscover': 'Back to discover',
      'about': 'About',
      'interests': 'Interests',
      'friendsAndRequests': 'Friends and requests',
      'searchFriends': 'Search friends',
      'friends': 'Friends',
      'incoming': 'Incoming',
      'outgoing': 'Outgoing',
      'accept': 'Accept',
      'reject': 'Reject',
      'cancelRequest': 'Cancel request',
      'noFriendsFound': 'No friends found.',
      'noIncomingRequests': 'No incoming requests.',
      'noOutgoingRequests': 'No outgoing requests.',
      'friendRequestAccepted': 'Friend request accepted.',
      'friendRequestRejected': 'Friend request rejected.',
      'friendRequestCancelled': 'Friend request cancelled.',
      'reportUser': 'Report user',
      'reportMessage': 'Report message',
      'selectReportReason': 'Select a reason',
      'harassment': 'Harassment',
      'spam': 'Spam',
      'hateSpeech': 'Hate speech',
      'inappropriateContent': 'Inappropriate content',
      'other': 'Other',
      'submitReport': 'Submit report',
      'reportConfirmation': 'Are you sure you want to submit this report?',
      'submit': 'Submit',
      'reportSubmitted': 'Report submitted.',
      'blockUser': 'Block user',
      'block': 'Block',
      'userBlocked': 'User blocked.',
      'blockedUsers': 'Blocked users',
      'adminDemo': 'Admin demo',
      'adminDemoInfo': 'Mock admin tools for local testing only.',
      'adminDashboard': 'Admin dashboard',
      'adminDemoBanner': 'Admin demo — mock data only. Not connected to production.',
      'adminLastUpdated': 'Last updated: local mock data',
      'totalUsers': 'Total users',
      'dailyActiveUsers': 'Daily active users',
      'messagesSent': 'Messages sent',
      'activeRooms': 'Active rooms',
      'openReports': 'Open reports',
      'adminUsers': 'Users',
      'adminReports': 'Reports',
      'adminContent': 'Content',
      'adminSearchUsers': 'Search users',
      'adminWarn': 'Warn',
      'adminSuspend': 'Suspend',
      'adminBan': 'Ban',
      'adminUnban': 'Unban',
      'adminActive': 'Active',
      'adminWarned': 'Warned',
      'adminSuspended': 'Suspended',
      'adminBanned': 'Banned',
      'adminMarkReviewed': 'Mark reviewed',
      'adminDismiss': 'Dismiss',
      'adminOpen': 'Open',
      'adminReviewed': 'Reviewed',
      'adminDismissed': 'Dismissed',
      'adminRemove': 'Remove',
      'adminKeep': 'Keep',
      'privacySettings': 'Privacy & Safety',
      'lastSeenVisibility': 'Last seen visibility',
      'lastSeenVisibilityInfo': 'Control who can see when you were last active.',
      'profilePhotoVisibility': 'Profile photo visibility',
      'profilePhotoVisibilityInfo': 'Control who can see your profile photo.',
      'whoCanMessage': 'Who can message me',
      'whoCanMessageInfo': 'Choose who is allowed to start a private chat with you.',
      'whoCanAddToGroup': 'Who can add me to groups',
      'whoCanAddToGroupInfo': 'Choose who can add you to group chats.',
      'privacyLocalOnlyInfo': 'These privacy controls are saved on this device. They will be enforced by a future backend.',
      'blockedUsersInfo': 'Blocked users cannot message you.',
      'noBlockedUsers': 'No blocked users.',
      'unblock': 'Unblock',
      'userUnblocked': 'User unblocked.',
      'notifications': 'Notifications',
      'unread': 'Unread',
      'markAllAsRead': 'Mark all as read',
      'clearAll': 'Clear all',
      'clearNotifications': 'Clear notifications',
      'clearNotificationsConfirmation': 'Clear all notifications?',
      'noNotifications': 'No notifications.',
      'noUnreadNotifications': 'No unread notifications.',
      'deleteNotification': 'Delete notification',
      'blockUserConfirmation': 'Block {name}?',
      'mutualFriends': 'mutual friends',
      'members': 'members',
    },
    'bn': {
      'language': 'ভাষা',
      'english': 'English',
      'bangla': 'বাংলা',
      'back': 'ফিরে যান',
      'pageNotFound': 'পেজ পাওয়া যায়নি',
      'loading': 'লোড হচ্ছে',
      'tagline': 'কথায় কথায় গড়ে উঠুক বন্ধন',
      'welcomeDescription':
          'নিরাপদে কথা বলুন, বন্ধু খুঁজুন এবং নিজের কমিউনিটি গড়ে তুলুন।',
      'safetyBadge': 'বাংলাদেশের জন্য নিরাপদ সামাজিক প্ল্যাটফর্ম',
      'journeyTitle': 'Bondhon যাত্রা শুরু করুন',
      'guestAccessDescription':
          'অ্যাকাউন্ট তৈরি বা লগইন ছাড়াই সরাসরি প্রবেশ করুন।',
      'enterNow': 'এখনই প্রবেশ করুন',
      'viewLoginStructure': 'লগইন স্ট্রাকচার দেখুন',
      'guestModeInfo':
          'গেস্ট মোড চালু আছে। Firebase authentication পরে যুক্ত হবে।',
      'login': 'লগ ইন',
      'loginSubtitle':
          'এই ফিচারটি ভবিষ্যতে Firebase-এর সাথে চালু হবে।',
      'email': 'ইমেইল',
      'password': 'পাসওয়ার্ড',
      'forgotPassword': 'পাসওয়ার্ড ভুলে গেছেন?',
      'loginComingSoon': 'লগইন শীঘ্রই আসছে',
      'continueWithoutLogin': 'লগইন ছাড়া চালিয়ে যান',
      'viewRegisterStructure': 'রেজিস্ট্রেশন স্ট্রাকচার দেখুন',
      'register': 'অ্যাকাউন্ট তৈরি',
      'registerSubtitle':
          'রেজিস্ট্রেশন UI প্রস্তুত, তবে অ্যাকাউন্ট তৈরি এখনো বন্ধ।',
      'fullName': 'পূর্ণ নাম',
      'registrationComingSoon': 'রেজিস্ট্রেশন শীঘ্রই আসছে',
      'passwordRecovery': 'পাসওয়ার্ড পুনরুদ্ধার',
      'passwordRecoverySubtitle':
          'Firebase চালু হলে রিসেট লিংক ইমেইলে পাঠানো যাবে।',
      'resetComingSoon': 'পাসওয়ার্ড রিসেট শীঘ্রই আসছে',
      'guestUser': 'গেস্ট ইউজার',
      'guestModeActive': 'গেস্ট মোড চালু—লগইন প্রয়োজন নেই।',
      'welcomePrefix': 'স্বাগতম',
      'home': 'হোম',
      'chats': 'চ্যাট',
      'rooms': 'রুম',
      'discover': 'ডিসকভার',
      'profile': 'প্রোফাইল',
      'groups': 'গ্রুপ',
      'socialFeed': 'সোশ্যাল ফিড',
      'refreshFeed': 'ফিড রিফ্রেশ',
      'post': 'পোস্ট',
      'postCreated': 'পোস্ট লোকালি তৈরি হয়েছে।',
      'whatsOnYourMind': 'আপনার মনে কী আছে?',
      'publicPrivacy': 'পাবলিক',
      'friendsPrivacy': 'বন্ধুরা',
      'onlyMePrivacy': 'শুধু আমি',
      'like': 'লাইক',
      'comments': 'কমেন্ট',
      'comment': 'কমেন্ট',
      'writeComment': 'কমেন্ট লিখুন',
      'noComments': 'এখনো কোনো কমেন্ট নেই।',
      'postDetails': 'পোস্টের বিবরণ',
      'postNotFound': 'পোস্ট পাওয়া যায়নি।',
      'reportPost': 'পোস্ট রিপোর্ট',
      'justNow': 'এইমাত্র',
      'minutesAgo': '{count} মিনিট আগে',
      'hoursAgo': '{count} ঘণ্টা আগে',
      'daysAgo': '{count} দিন আগে',
      'groupsDescription': 'পাবলিক ও প্রাইভেট কমিউনিটি খুঁজুন এবং গেস্ট হিসেবে চ্যাট করুন।',
      'createGroup': 'গ্রুপ তৈরি',
      'groupName': 'গ্রুপের নাম',
      'groupDescription': 'গ্রুপের বিবরণ',
      'publicGroup': 'পাবলিক গ্রুপ',
      'privateGroup': 'প্রাইভেট গ্রুপ',
      'publicGroupInfo': 'যে কেউ এই গ্রুপ খুঁজে জয়েন করতে পারবে।',
      'privateGroupInfo': 'শুধু আমন্ত্রিত সদস্যরা দেখতে পাবে।',
      'searchGroups': 'গ্রুপ খুঁজুন',
      'noGroupsFound': 'কোনো গ্রুপ মিলেনি।',
      'groupNotFound': 'গ্রুপ পাওয়া যায়নি।',
      'rolesPreview': 'রোল',
      'owner': 'মালিক',
      'admin': 'অ্যাডমিন',
      'member': 'সদস্য',
      'memberPreview': 'সদস্য প্রিভিউ',
      'copyInviteLink': 'ইনভাইট লিংক কপি',
      'inviteLinkCopied': 'ডামি ইনভাইট লিংক কপি হয়েছে।',
      'leaveGroup': 'গ্রুপ ছেড়ে যান',
      'adminOnlyMessaging': 'এই গ্রুপে শুধু অ্যাডমিনরা মেসেজ পাঠাতে পারে।',
      'chatRooms': 'চ্যাট রুম',
      'comingSoon': 'শীঘ্রই আসছে',
      'chatsDescription': 'আপনার প্রাইভেট ও গ্রুপ কথোপকথন এখানে দেখা যাবে।',
      'roomsDescription': 'পাবলিক চ্যাট ও ভয়েস রুমে যোগ দিন।',
      'discoverDescription': 'মানুষ, কমিউনিটি ও ট্রেন্ডিং টপিক খুঁজুন।',
      'profileDescription': 'আপনার গেস্ট প্রোফাইল ও পছন্দ এখানে দেখা যাবে।',
      'guestAccount': 'গেস্ট অ্যাকাউন্ট',
      'personalInformation': 'ব্যক্তিগত তথ্য',
      'editProfile': 'প্রোফাইল সম্পাদনা',
      'cancel': 'বাতিল',
      'username': 'ইউজারনেম',
      'usernameHelp': '৩–২০ অক্ষর, সংখ্যা বা আন্ডারস্কোর ব্যবহার করুন।',
      'gender': 'লিঙ্গ',
      'male': 'পুরুষ',
      'female': 'নারী',
      'preferNotToSay': 'বলতে চাই না',
      'country': 'দেশ',
      'bio': 'বায়ো',
      'requiredField': 'এই ঘরটি আবশ্যক।',
      'saveChanges': 'পরিবর্তন সংরক্ষণ',
      'profileSaved': 'প্রোফাইল এই ডিভাইসে সংরক্ষিত হয়েছে।',
      'languageSettingsInfo': 'অ্যাপ বারে ভাষা সিলেক্টর ব্যবহার করুন।',
      'exitGuestMode': 'গেস্ট মোড থেকে বেরোন',
      'exitGuestModeInfo': 'প্রোফাইল মুছে না ফেলে ওয়েলকাম স্ক্রিনে ফিরে যান।',
      'publicChatRooms': 'পাবলিক চ্যাট রুম',
      'publicChatRoomsDescription': 'ওপেন রুমে যোগ দিন এবং গেস্ট হিসেবে চ্যাট করুন।',
      'searchRooms': 'রুম খুঁজুন',
      'clearSearch': 'সার্চ মুছুন',
      'all': 'সব',
      'friendship': 'বন্ধুত্ব',
      'regional': 'আঞ্চলিক',
      'education': 'শিক্ষা',
      'entertainment': 'বিনোদন',
      'noRoomsFound': 'কোনো রুম মিলেনি।',
      'live': 'লাইভ',
      'viewRoom': 'রুম দেখুন',
      'roomNotFound': 'রুম পাওয়া যায়নি।',
      'backToRooms': 'রুমে ফিরে যান',
      'joinAsGuest': 'গেস্ট হিসেবে জয়েন',
      'joined': 'জয়েন করেছেন',
      'typeMessage': 'মেসেজ লিখুন',
      'send': 'পাঠান',
      'joinToSendMessages': 'মেসেজ পাঠাতে রুমে জয়েন করুন।',
      'privateChats': 'প্রাইভেট চ্যাট',
      'privateChatsDescription': 'আপনার ওয়ান-টু-ওয়ান কথোপকথন।',
      'searchConversations': 'কথোপকথন খুঁজুন',
      'noConversationsFound': 'কোনো কথোপকথন পাওয়া যায়নি।',
      'online': 'অনলাইন',
      'offline': 'অফলাইন',
      'conversationNotFound': 'কথোপকথন পাওয়া যায়নি।',
      'backToChats': 'চ্যাটে ফিরে যান',
      'startConversation': 'কথোপকথন শুরু',
      'conversationInfo': 'কথোপকথনের তথ্য',
      'profileComingSoon': 'প্রোফাইল বিবরণ শীঘ্রই আসছে।',
      'read': 'পঠিত',
      'sent': 'পাঠানো',
      'discoverPeople': 'মানুষ খুঁজুন',
      'discoverPeopleDescription': 'একই আগ্রহের বন্ধু খুঁজুন।',
      'searchPeople': 'মানুষ খুঁজুন',
      'onlineNow': 'এখন অনলাইন',
      'nearby': 'কাছাকাছি',
      'commonInterests': 'সাধারণ আগ্রহ',
      'noPeopleFound': 'কাউকে পাওয়া যায়নি।',
      'viewProfile': 'প্রোফাইল দেখুন',
      'addFriend': 'বন্ধু যোগ করুন',
      'requestSent': 'রিকোয়েস্ট পাঠানো হয়েছে',
      'message': 'মেসেজ',
      'userNotFound': 'ইউজার পাওয়া যায়নি।',
      'backToDiscover': 'ডিসকভারে ফিরে যান',
      'about': 'সম্পর্কে',
      'interests': 'আগ্রহ',
      'friendsAndRequests': 'বন্ধু ও রিকোয়েস্ট',
      'searchFriends': 'বন্ধু খুঁজুন',
      'friends': 'বন্ধুরা',
      'incoming': 'ইনকামিং',
      'outgoing': 'আউটগোয়িং',
      'accept': 'গ্রহণ',
      'reject': 'প্রত্যাখ্যান',
      'cancelRequest': 'রিকোয়েস্ট বাতিল',
      'noFriendsFound': 'কোনো বন্ধু পাওয়া যায়নি।',
      'noIncomingRequests': 'কোনো ইনকামিং রিকোয়েস্ট নেই।',
      'noOutgoingRequests': 'কোনো আউটগোয়িং রিকোয়েস্ট নেই।',
      'friendRequestAccepted': 'বন্ধুত্বের অনুরোধ গৃহীত।',
      'friendRequestRejected': 'বন্ধুত্বের অনুরোধ প্রত্যাখ্যাত।',
      'friendRequestCancelled': 'বন্ধুত্বের অনুরোধ বাতিল।',
      'reportUser': 'ইউজার রিপোর্ট',
      'reportMessage': 'মেসেজ রিপোর্ট',
      'selectReportReason': 'কারণ নির্বাচন করুন',
      'harassment': 'হয়রানি',
      'spam': 'স্প্যাম',
      'hateSpeech': 'ঘৃণামূলক বক্তব্য',
      'inappropriateContent': 'অনুপযুক্ত কন্টেন্ট',
      'other': 'অন্যান্য',
      'submitReport': 'রিপোর্ট জমা দিন',
      'reportConfirmation': 'আপনি কি এই রিপোর্ট জমা দিতে চান?',
      'submit': 'জমা দিন',
      'reportSubmitted': 'রিপোর্ট জমা হয়েছে।',
      'blockUser': 'ইউজার ব্লক',
      'block': 'ব্লক',
      'userBlocked': 'ইউজার ব্লক করা হয়েছে।',
      'blockedUsers': 'ব্লক করা ইউজার',
      'adminDemo': 'অ্যাডমিন ডেমো',
      'adminDemoInfo': 'শুধু লোকাল টেস্টিংয়ের জন্য মক অ্যাডমিন টুল।',
      'adminDashboard': 'অ্যাডমিন ড্যাশবোর্ড',
      'adminDemoBanner': 'অ্যাডমিন ডেমো — শুধু মক ডেটা। প্রোডাকশনের সাথে সংযুক্ত নয়।',
      'adminLastUpdated': 'সর্বশেষ আপডেট: লোকাল মক ডেটা',
      'totalUsers': 'মোট ইউজার',
      'dailyActiveUsers': 'দৈনিক সক্রিয় ইউজার',
      'messagesSent': 'পাঠানো মেসেজ',
      'activeRooms': 'সক্রিয় রুম',
      'openReports': 'খোলা রিপোর্ট',
      'adminUsers': 'ইউজার',
      'adminReports': 'রিপোর্ট',
      'adminContent': 'কন্টেন্ট',
      'adminSearchUsers': 'ইউজার খুঁজুন',
      'adminWarn': 'সতর্ক',
      'adminSuspend': 'সাসপেন্ড',
      'adminBan': 'ব্যান',
      'adminUnban': 'আনব্যান',
      'adminActive': 'সক্রিয়',
      'adminWarned': 'সতর্ককৃত',
      'adminSuspended': 'সাসপেন্ডেড',
      'adminBanned': 'ব্যানড',
      'adminMarkReviewed': 'রিভিউড চিহ্নিত',
      'adminDismiss': 'খারিজ',
      'adminOpen': 'খোলা',
      'adminReviewed': 'রিভিউড',
      'adminDismissed': 'খারিজ',
      'adminRemove': 'সরান',
      'adminKeep': 'রাখুন',
      'privacySettings': 'প্রাইভেসি ও সেফটি',
      'lastSeenVisibility': 'শেষবার সক্রিয় থাকার তথ্য',
      'lastSeenVisibilityInfo': 'কে আপনার লাস্ট সিন দেখতে পারবে তা নিয়ন্ত্রণ করুন।',
      'profilePhotoVisibility': 'প্রোফাইল ছবির দৃশ্যমানতা',
      'profilePhotoVisibilityInfo': 'কে আপনার প্রোফাইল ছবি দেখতে পারবে তা নিয়ন্ত্রণ করুন।',
      'whoCanMessage': 'কে আমাকে মেসেজ করতে পারবে',
      'whoCanMessageInfo': 'কে আপনার সাথে প্রাইভেট চ্যাট শুরু করতে পারবে তা বেছে নিন।',
      'whoCanAddToGroup': 'কে আমাকে গ্রুপে যোগ করতে পারবে',
      'whoCanAddToGroupInfo': 'কে আপনাকে গ্রুপ চ্যাটে যোগ করতে পারবে তা বেছে নিন।',
      'privacyLocalOnlyInfo': 'এই প্রাইভেসি সেটিংগুলো এই ডিভাইসেই সংরক্ষিত হয়। ভবিষ্যৎ backend এগুলো কার্যকর করবে।',
      'blockedUsersInfo': 'ব্লক করা ইউজার আপনাকে মেসেজ করতে পারবে না।',
      'noBlockedUsers': 'কোনো ব্লক করা ইউজার নেই।',
      'unblock': 'আনব্লক',
      'userUnblocked': 'ইউজার আনব্লক করা হয়েছে।',
      'notifications': 'নোটিফিকেশন',
      'unread': 'অপঠিত',
      'markAllAsRead': 'সব পঠিত চিহ্নিত করুন',
      'clearAll': 'সব মুছুন',
      'clearNotifications': 'নোটিফিকেশন মুছুন',
      'clearNotificationsConfirmation': 'সব নোটিফিকেশন মুছে ফেলবেন?',
      'noNotifications': 'কোনো নোটিফিকেশন নেই।',
      'noUnreadNotifications': 'কোনো অপঠিত নোটিফিকেশন নেই।',
      'deleteNotification': 'নোটিফিকেশন মুছুন',
      'blockUserConfirmation': '{name}-কে ব্লক করবেন?',
      'mutualFriends': 'পারস্পরিক বন্ধু',
      'members': 'সদস্য',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.isSupported(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
