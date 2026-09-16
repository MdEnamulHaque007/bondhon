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
