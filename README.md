# QLogFork

This is a personal fork of [QLog](https://github.com/foldynl/QLog) by foldynl — an Amateur Radio logging application for Linux, Windows and MacOS.

For documentation, installation instructions, features, and support please refer to the **upstream repository**:

> **https://github.com/foldynl/QLog**

---

## Extra features in this fork

- Fix ADIF import losing diacritics (UTF-8 instead of Latin-1) [PR#996](https://github.com/foldynl/QLog/pull/996)
- CLI backup: `--backup-db` flag to pack data & settings without the GUI — see [docs/cli-backup.md](docs/cli-backup.md)
- Better QRZ.com upload errors: the failure popup now identifies the failing QSO (callsign, UTC date/time, band) and includes the `EXTENDED` field from QRZ's API response, which carries the real cause (e.g. "freq_to_band: cannot determine band from 13.785") instead of QRZ's generic "Internal Error" message

---

## License

Same as upstream — [GPL-3.0-or-later](LICENSE).
