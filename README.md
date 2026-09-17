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
- Initial tabs: Home, Chats, Rooms, Discover, and Profile

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

## Private chats

- Searchable one-to-one conversation list with online status and unread badges
- Direct-chat routes with sample conversation history
- Guest message composer with local sent/read presentation
- Invalid-conversation handling and bilingual interface text

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
