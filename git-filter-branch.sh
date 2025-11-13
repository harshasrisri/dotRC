#!/bin/sh

NEW_EMAIL=$(git config user.email)
NEW_NAME=$(git config user.name)

# Create a mailmap for the changes
cat > /tmp/mailmap <<EOF
${NEW_NAME} <${NEW_EMAIL}> Sriharsha Mucheli Sukumar
EOF

# Apply the mailmap
git filter-repo --mailmap /tmp/mailmap --force
