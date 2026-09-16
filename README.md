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
  --dart-define=API_BASE_URL=https://api.example.com
```

Supported `APP_ENV` values are `development`, `staging`, and `production`.
Never commit secrets to the repository; production secrets will be configured
through Firebase/Vercel when those services are added.

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
- User profile and username
- Public chat rooms
- Private messaging
- Friends and online presence
- Image and voice messages
- Push notifications
- Block, report and moderation
- Bangla and English localization
