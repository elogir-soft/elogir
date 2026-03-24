import 'dart:io';

import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:ota_update/ota_update.dart';

import 'elogir_updater.dart';

/// Shows a dialog prompting the user to install an available update.
///
/// Call this after [ElogirUpdater.checkForUpdate] returns a non-null release.
/// On Android, tapping "Update" triggers an OTA download and install via the
/// system package installer.
Future<void> showUpdateDialog({
  required BuildContext context,
  required ElogirRelease release,
  required ElogirUpdater updater,
}) {
  return ElogirDialog.show(
    context: context,
    barrierDismissible: false,
    builder: (context) => _UpdateDialogContent(
      release: release,
      updater: updater,
    ),
  );
}

class _UpdateDialogContent extends StatefulWidget {
  const _UpdateDialogContent({
    required this.release,
    required this.updater,
  });

  final ElogirRelease release;
  final ElogirUpdater updater;

  @override
  State<_UpdateDialogContent> createState() => _UpdateDialogContentState();
}

enum _DialogState { prompt, downloading, error }

class _UpdateDialogContentState extends State<_UpdateDialogContent> {
  _DialogState _state = _DialogState.prompt;
  String _progress = '';
  String _errorMessage = '';

  void _startUpdate() {
    if (!Platform.isAndroid) return;

    setState(() => _state = _DialogState.downloading);

    widget.updater.update(widget.release.downloadUrl).listen(
      (event) {
        if (!mounted) return;
        switch (event.status) {
          case OtaStatus.DOWNLOADING:
            setState(() => _progress = event.value ?? '');
          case OtaStatus.INSTALLING:
            // System installer takes over — dismiss dialog.
            Navigator.of(context).pop();
          case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
            setState(() {
              _state = _DialogState.error;
              _errorMessage = 'Install permission not granted.';
            });
          case OtaStatus.DOWNLOAD_ERROR:
          case OtaStatus.INTERNAL_ERROR:
          case OtaStatus.CHECKSUM_ERROR:
            setState(() {
              _state = _DialogState.error;
              _errorMessage = 'Download failed. Please try again.';
            });
          case OtaStatus.ALREADY_RUNNING_ERROR:
            setState(() {
              _state = _DialogState.error;
              _errorMessage = 'Another update is already in progress.';
            });
        }
      },
      onError: (_) {
        if (!mounted) return;
        setState(() {
          _state = _DialogState.error;
          _errorMessage = 'Download failed. Please try again.';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _DialogState.prompt => _buildPrompt(context),
      _DialogState.downloading => _buildDownloading(context),
      _DialogState.error => _buildError(context),
    };
  }

  Widget _buildPrompt(BuildContext context) {
    final changelog = widget.release.changelog;

    return ElogirDialog(
      title: const Text('Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Version ${widget.release.version} is ready to install.'),
          if (changelog.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(changelog),
          ],
        ],
      ),
      actions: [
        ElogirButton(
          variant: ElogirButtonVariant.ghost,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Later'),
        ),
        ElogirButton(
          onPressed: _startUpdate,
          child: const Text('Update'),
        ),
      ],
    );
  }

  Widget _buildDownloading(BuildContext context) {
    return ElogirDialog(
      title: const Text('Downloading Update'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ElogirSpinner(),
          if (_progress.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('$_progress%'),
          ],
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return ElogirDialog(
      title: const Text('Update Failed'),
      content: Text(_errorMessage),
      actions: [
        ElogirButton(
          variant: ElogirButtonVariant.ghost,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Dismiss'),
        ),
        ElogirButton(
          onPressed: () {
            setState(() {
              _state = _DialogState.prompt;
              _errorMessage = '';
            });
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
