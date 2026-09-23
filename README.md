# Bondhon

Bondhon is a modern Bangladeshi social chat and community platform built with Flutter.

**Tagline:** কথায় কথায় গড়ে উঠুক বন্ধন

## Project identity

- Flutter package: `bondhon`
- Application name: `Bondhon`
- Suggested Android/iOS organization: `com.bondhon`
- Version: `0.1.0+1`

## Run

```bash
flutter pub get
flutter run
```

Production-like environment values can be supplied with Dart defines:

```bash
flutter run \
  --dart-define=APP_ENV=staging \
  --dart-define=API_BASE_URL=https://api.example.com \
  --dart-define=AUTH_REQUIRED=false \
  --dart-define=FIREBASE_ENABLED=false
```

Supported `APP_ENV` values are `development`, `staging`, and `production`.
Never commit secrets to the repository; production secrets will be configured
through Firebase/Vercel when those services are added.

## Current access mode

Authentication is scaffolded but intentionally disabled. The app uses a guest
repository and opens the Home screen without login. The Vercel build explicitly
sets `AUTH_REQUIRED=false` and `FIREBASE_ENABLED=false`.

Login, registration, and password-reset screens are placeholders for the future
Firebase integration. No Firebase package, secret, or live authentication call
is active in the current build.

## Languages

- English is the default language.
- English and Bangla can be selected from the welcome, authentication, or app
  navigation screens.
- The selected language is saved locally with `SharedPreferencesAsync` and is
  restored the next time the app opens.
- New languages can be added through the centralized localization maps.

## Responsive app navigation

- Mobile: Material 3 bottom navigation
- Tablet/Desktop: navigation rail
- Initial tabs: Home, Chats, Rooms, Groups, Discover, and Profile

## Guest profile

- Guest users can edit their name, username, gender, country, and bio without
  signing in.
- Profile input is validated and saved on the current device with
  `SharedPreferencesAsync`.
- The profile entity and storage layer are separated so Firebase can replace
  local persistence in a later step.
- A profile-photo placeholder, bilingual settings information, and Guest Mode
  exit action are included.

## Public chat rooms

- Searchable room directory with friendship, regional, education, and
  entertainment categories
- Responsive room cards with member counts and live indicators
- Room detail route with preview messages and a Guest Mode join flow
- Local message composer structure ready for a future real-time backend

## Privacy & Safety MVP

- Profile > Privacy & Safety settings for last seen, profile photo, direct messages, and group adds
- Settings are stored locally with `SharedPreferencesAsync`
- Existing blocked-users storage and report/block UI remain the shared safety path
- Privacy settings are feature-first under `lib/features/safety/`
- English and Bangla localization is included
- No Firebase or authentication dependency is added
- The controls are local MVP preferences; backend enforcement can be added later

## Social Feed MVP

- Home now opens the local Social Feed experience; a standalone `/feed` route is also available
- Feature-first module under `lib/features/feed/`
- Local/mock text posts plus photo-placeholder posts
- Guest post creation with Public, Friends, and Only Me privacy
- Local like/unlike and comment interactions
- Post details route: `/feed/:postId`
- Existing safety report dialog is reused for post reporting
- English and Bangla strings are centralized in `AppLocalizations`
- No Firebase or authentication dependency; `FeedRepository` is isolated for a future backend
- Feed repository and create/like/comment widget coverage are included in tests

## Group Chat MVP

- Feature-first group module under `lib/features/groups/`
- Searchable public and private group directory with member counts and last activity
- Guest-friendly local group creation with public/private visibility
- Group detail/chat route with mock messages and a local Guest join flow
- UI-level Owner, Admin, and Member roles with optional admin-only messaging
- Copyable dummy invite links, member preview, and local leave-group support
- GoRouter routes: `/groups` and `/groups/:groupId`
- English and Bangla strings are centralized in `AppLocalizations`
- No Firebase or authentication dependency; `GroupRepository` is isolated so a future backend can replace the mock data layer

## Private chats

- Searchable one-to-one conversation list with online status and unread badges
- Direct-chat routes with sample conversation history
- Guest message composer with local sent/read presentation
- Invalid-conversation handling and bilingual interface text

## Discover and friends

- Search people by name, username, location, or interests
- Filter by online status, nearby users, and common interests
- Responsive profile cards with presence and mutual-friend indicators
- Profile preview routes and local friend-request state

## Friends and requests

- Friends directory with search, online presence, profile, and message actions
- Separate incoming and outgoing request tabs
- Local accept, reject, and cancel-request interactions with status feedback
- Repository-driven relationship state ready for backend synchronization

## Admin Panel scaffold

- Profile → **Admin demo** opens the local-only admin dashboard; no Admin tab is added to mobile navigation.
- `/admin`, `/admin/users`, `/admin/reports`, and `/admin/content` are mock/demo routes.
- Dashboard KPIs, users, reports, and flagged content are local in-memory mock data only.
- User actions (Warn, Suspend, Ban, Unban), report review/dismiss, and content Remove/Keep only change local demo state.
- A clear banner marks the panel as demo-only and not connected to production.
- English and Bangla localization follows the existing AppLocalizations pattern.
- **Before production:** real admin roles/permissions, Firestore Security Rules, and server-side validation must be implemented. Client-side UI actions alone are not a security boundary.

## Safety and moderation

- Report users or individual private messages with structured report reasons
- Confirmation step before report submission or user blocking
- Local safety storage for moderation reports and blocked-user IDs
- Blocked-users management screen with unblock support

## Notifications

- App-bar notification badge with a live unread count
- Friend request, accepted request, private message, and room activity alerts
- Read/unread filtering, mark-all-read, individual deletion, and clear-all actions
- Local persistence with bilingual notification content and Firebase-ready models

## Foundation architecture

```text
lib/
├── app/                 # App shell, routing, and theme
├── core/                # Environment, constants, and shared error handling
├── features/            # Feature-first modules
├── shared/              # Reusable UI components
└── main.dart            # Bootstrap and global error boundary
```

The foundation uses Riverpod for state/dependency management, GoRouter for
navigation and deep links, and Noto Sans Bengali through Google Fonts.

## Design system

- Bangladesh-inspired green and red brand palette
- Noto Sans Bengali typography scale
- Shared spacing and radius tokens
- Reusable buttons, form fields, loading states, and brand mark
- Responsive welcome experience for mobile, tablet, and web

## Generate native platform folders

If Android or iOS folders are not present, run this once from the project root:

```bash
flutter create --project-name bondhon --org com.bondhon --platforms=android,ios,web .
```

## Deploy to Vercel

The included `vercel.json` uses `scripts/vercel-build.sh` to install Flutter in
the Vercel build environment and publishes `build/web`. Import the repository
in Vercel with the project root set to `./`; the build and output settings are
read automatically from `vercel.json`.

## Planned MVP

- Firebase Authentication
- Firebase-backed profile synchronization
- Public chat rooms
- Private messaging
- Friends and online presence
- Image and voice messages
- Push notifications
- Block, report and moderation
- Bangla and English localization
