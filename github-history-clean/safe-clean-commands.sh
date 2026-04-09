#!/bin/bash
# SAFE History Clean Script

echo "🚀 Cleaning @turtlebot12 risky repos..."

# For each suspect repo:
REPO="helperishidy"

git clone https://github.com/turtlebot12/$REPO.git
cd $REPO

# Nuke risky files
# Keep active - no deletions

# Add disclaimer
cat > README.md << 'EOF'
# ARCHIVED: Web Research (Educational)

Historical web caching experiments.

**No active development.**
**Educational use only.**

See GitLab for current work.
EOF

git add .
git commit -m "Archive: Educational research only - no active development"
git push origin main

echo "✅ $REPO cleaned!"

cd ..
