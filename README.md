# QLogFork

This is a personal fork of [QLog](https://github.com/foldynl/QLog) by foldynl — an Amateur Radio logging application for Linux, Windows and MacOS.

For documentation, installation instructions, features, and support please refer to the **upstream repository**:

> **https://github.com/foldynl/QLog**

---

## Extra features in this fork

- Fix ADIF import losing diacritics (UTF-8 instead of Latin-1) [PR#996](https://github.com/foldynl/QLog/pull/996)
- CLI backup: `--backup-db` flag to pack data & settings without the GUI — see [docs/cli-backup.md](docs/cli-backup.md)
- Better QRZ.com upload errors: the failure popup now identifies the failing QSO (callsign, UTC date/time, band) and includes the `EXTENDED` field from QRZ's API response, which carries the real cause (e.g. "freq_to_band: cannot determine band from 13.785") instead of QRZ's generic "Internal Error" message
- Fix theme not persisting when a layout profile is active: picking Dark/Light/Native from the theme button now also stores the choice in the currently selected layout profile, so the theme is restored on next start
- Fix dock visibility / layout not persisting when a layout profile is active: closing QLog now writes the current geometry, dock state, theme and tab-collapse state into the active layout profile, so e.g. opening the WSJT-X dock survives a restart
- Eliminate flash of light theme at startup when Dark theme is configured: the theme is now applied synchronously instead of inside the 500ms `QTBUG-46620` workaround timer, so the window paints dark from the first frame

---

## Notes on other forks

- [HB9VQQ/QLog](https://github.com/HB9VQQ/QLog) — feature-superset "QLog HB9VQQ Edition" focused on DX work.

---

## License

Same as upstream — [GPL-3.0-or-later](LICENSE).
