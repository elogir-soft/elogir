import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

/// Service to handle auto-updates for Elogir apps via GitHub Releases.
class ElogirUpdater {
  ElogirUpdater({
    required this.owner,
    required this.repo,
    required this.appPrefix,
  });

  /// The GitHub repository owner.
  final String owner;

  /// The GitHub repository name.
  final String repo;

  /// The prefix for the app tags (e.g., 'elogir_alarm').
  final String appPrefix;

  /// Checks for a new release and returns the release info if available.
  Future<ElogirRelease?> checkForUpdate() async {
    try {
      final dio = Dio();
      final response = await dio.get<List<dynamic>>(
        'https://api.github.com/repos/$owner/$repo/releases',
      );

      final releases = response.data;
      if (releases == null) return null;

      final tagPrefix = '$appPrefix-v';

      // Find the latest release that matches our app prefix.
      // GitHub API returns releases ordered by date (newest first).
      final appReleaseData = releases.cast<Map<String, dynamic>>().where(
        (r) => (r['tag_name'] as String).startsWith(tagPrefix),
      );

      if (appReleaseData.isEmpty) return null;

      final latest = appReleaseData.first;
      final latestTag = latest['tag_name'] as String;
      final latestVersion = latestTag.substring(tagPrefix.length);

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (Version.parse(latestVersion) > Version.parse(currentVersion)) {
        // Find APK asset.
        final assets = latest['assets'] as List<dynamic>;
        final apkAsset = assets.cast<Map<String, dynamic>>().where(
          (a) => (a['name'] as String).endsWith('.apk'),
        );

        if (apkAsset.isEmpty) return null;

        return ElogirRelease(
          version: latestVersion,
          downloadUrl: apkAsset.first['browser_download_url'] as String,
          changelog: latest['body'] as String? ?? '',
        );
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
    return null;
  }

  /// Downloads and installs the update.
  /// Only supported on Android.
  Stream<OtaEvent> update(String downloadUrl) {
    if (!Platform.isAndroid) {
      throw UnsupportedError('Auto-update is only supported on Android.');
    }

    return OtaUpdate().execute(
      downloadUrl,
      destinationFilename: '$appPrefix.apk',
    );
  }
}

/// Information about an available update.
class ElogirRelease {
  ElogirRelease({
    required this.version,
    required this.downloadUrl,
    required this.changelog,
  });

  final String version;
  final String downloadUrl;
  final String changelog;
}
