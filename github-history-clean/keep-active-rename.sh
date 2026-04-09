#!/bin/bash
# KEEP HELPERISHIDY ACTIVE - Just Rename + Safe README

echo "🚀 Active Rename Helperishidy → web-cache-research"

REPO="helperishidy"

git clone https://github.com/turtlebot12/$REPO.git
cd $REPO

# KEEP ALL CODE ACTIVE - Just safe README
cat > README.md << 'EOF'
# Web Cache Research 🔬

Educational project studying:
• Multi-cache fetching (Google/Bing/Archive)
• HTML proxy rewriting techniques
• Nginx Lua performance

**Academic/Research use only.**

## Quickstart:
\`\`\`bash
docker-compose up
\`\`\`

Docker images: turtlebot/proxy-v1
EOF

# Add badge
echo '![Docker](https://img.shields.io/docker/pulls/turtlebot/proxy-v1)' >| badges.md

git add .
git commit -m "Active: Educational research update - web cache study"
git push origin main

echo "✅ web-cache-research ACTIVE + SAFE!"
cd ..

