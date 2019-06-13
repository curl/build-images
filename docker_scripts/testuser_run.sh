#!/usr/bin/env bash

# Ensure that we're running with the same user credentials (UID, GID) as the
# host OS, to ensure that any files are created with the right permissions.

set -euxo pipefail

EXTUID=${1}
EXTGID=${2}

shift 2
COMMAND="$@"

# Switch the testuser to use the passed in values for UID and GID.
usermod -u ${EXTUID} testuser
groupmod -g ${EXTGID} testuser
usermod -g ${EXTGID} testuser

# Run the command as testuser.
su -c "${COMMAND}" testuser
