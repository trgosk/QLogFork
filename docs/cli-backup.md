# CLI Backup — `--backup-db`

Pack your QLog database and settings from the command line without opening the GUI.
This is the headless equivalent of **File → Pack Data && Settings**.

## Flags

| Flag | Required | Description |
|------|----------|-------------|
| `--backup-db <file>` | Yes | Destination path for the backup. The `.dbe` extension is appended automatically if missing. |
| `--backup-password <pass>` | No | Password used to encrypt stored service credentials inside the backup. If omitted an empty password is used (credentials are still encrypted, just with a blank key). |

## Examples

```bash
# Basic backup (empty password)
qlog --backup-db ~/backups/mylog.dbe

# Backup with a password protecting the stored credentials
qlog --backup-db ~/backups/mylog.dbe --backup-password s3cr3t

# Date-stamped backup suitable for a cron job
qlog --backup-db ~/backups/mylog_$(date +%Y%m%d).dbe --backup-password s3cr3t
```

## Exit codes

| Code | Meaning |
|------|---------|
| `0` | Backup written successfully |
| `1` | An error occurred (message printed to `stderr`) |

## Headless / server use

On a machine without a display, pass `-platform offscreen` to suppress the Qt
platform warning:

```bash
qlog --backup-db /mnt/nas/mylog.dbe --backup-password s3cr3t -platform offscreen
```

## Restore

Load the resulting `.dbe` file back through **File → Load Data && Settings** in
the GUI, or use the `--import-pending` mechanism (see upstream docs).

## Notes

- QLog must **not** already be running when the backup command is issued (the
  single-instance guard applies).
- The backup captures the live SQLite database via an atomic hot-copy, so no
  manual shutdown is needed — just make sure no other `qlog` process is active.
- Credentials are always encrypted inside the `.dbe` file; the password controls
  the encryption key, not whether encryption occurs.
