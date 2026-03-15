# elogir_updater

Auto-update service for elogir apps. Checks GitHub Releases for new versions and installs APK updates via OTA on Android.

Part of the [elogir monorepo](../../README.md).

## How It Works

1. Queries the GitHub Releases API for releases matching the app's prefix
2. Compares the latest release version against the installed app version using semantic versioning
3. If an update is available, downloads and installs the APK via OTA

Android only -- throws `UnsupportedError` on other platforms.

## Usage

```dart
import 'package:elogir_updater/elogir_updater.dart';

final updater = ElogirUpdater(
  owner: 'your-github-org',
  repo: 'your-repo',
  appPrefix: 'elogir_alarm',
);

// Check for updates
final release = await updater.checkForUpdate();
if (release != null) {
  print('Update available: ${release.version}');
  print('Changelog: ${release.changelog}');
  await updater.update(release);
}
```

### Key Classes

- **`ElogirUpdater`** -- main service (owner, repo, appPrefix)
- **`ElogirRelease`** -- release metadata (version, downloadUrl, changelog)
