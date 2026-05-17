#!/bin/bash
# Usage: ./devtools/set_version.sh <version>
# Example: ./devtools/set_version.sh 0.51.0

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.51.0"
    exit 1
fi

VERSION="$1"
DATE=$(date +%Y-%m-%d)
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Setting version to $VERSION (date: $DATE)"

# QLog.pro
sed -i "s/^VERSION = .*/VERSION = $VERSION/" "$SCRIPT_DIR/QLog.pro"

# AppStream metainfo — prepend new release entry
METAINFO="$SCRIPT_DIR/res/io.github.trgosk.QLogFork.metainfo.xml"
sed -i "s|<release version=\"[^\"]*\" date=\"[^\"]*\">|<release version=\"$VERSION\" date=\"$DATE\">|1" "$METAINFO"

# Qt Installer config
sed -i "s|<Version>.*</Version>|<Version>$VERSION</Version>|" "$SCRIPT_DIR/installer/config/config.xml"

# Qt Installer package (version with -1 suffix)
sed -i "s|<Version>.*</Version>|<Version>$VERSION-1</Version>|" "$SCRIPT_DIR/installer/packages/de.dl2ic.qlog/meta/package.xml"
sed -i "s|<ReleaseDate>.*</ReleaseDate>|<ReleaseDate>$DATE</ReleaseDate>|" "$SCRIPT_DIR/installer/packages/de.dl2ic.qlog/meta/package.xml"

# debian/changelog — prepend new entry
DEBENTRY="qlog ($VERSION-1) UNRELEASED; urgency=low

  * Release $VERSION

 -- trgosk <trgo.sk@gmail.com>  $(date -R)
"
TMPFILE=$(mktemp)
printf '%s\n' "$DEBENTRY" | cat - "$SCRIPT_DIR/debian/changelog" > "$TMPFILE"
mv "$TMPFILE" "$SCRIPT_DIR/debian/changelog"

echo "Done. Files updated:"
echo "  QLog.pro"
echo "  res/io.github.trgosk.QLogFork.metainfo.xml"
echo "  installer/config/config.xml"
echo "  installer/packages/de.dl2ic.qlog/meta/package.xml"
echo "  debian/changelog"
echo ""
echo "Note: rpm_spec/qlog.spec uses REPO_VERSION env var — set it when building the RPM."
