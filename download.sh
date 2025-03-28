#!/bin/bash
# Script to download external assets and set them up for local hosting
# Created for Adishesha Institute Of Yogic Sciences

echo "==== External Assets Local Setup Script ===="
echo "This script will download and set up local versions of:"
echo "- Google Fonts (Playfair Display, Cormorant Garamond, Poppins)"
echo "- Font Awesome 6.4.0"
echo "- Animate.css"
echo ""

# Create directory structure
mkdir -p assets/fonts/{playfair,cormorant,poppins}
mkdir -p assets/css
mkdir -p assets/webfonts

echo "Directory structure created."

# Download Google Fonts
echo "Downloading Google Fonts..."

# Playfair Display
wget -q --show-progress "https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" -O temp_playfair.css

# Extract font URLs from CSS
grep -o "https://fonts.gstatic.com/s/playfairdisplay/[^)]*" temp_playfair.css > playfair_urls.txt

# Download each font file
while read url; do
  wget -q --show-progress "$url" -O "assets/fonts/playfair/$(basename "$url")"
done < playfair_urls.txt

# Cormorant Garamond
wget -q --show-progress "https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&display=swap" -O temp_cormorant.css

# Extract font URLs from CSS
grep -o "https://fonts.gstatic.com/s/cormorantgaramond/[^)]*" temp_cormorant.css > cormorant_urls.txt

# Download each font file
while read url; do
  wget -q --show-progress "$url" -O "assets/fonts/cormorant/$(basename "$url")"
done < cormorant_urls.txt

# Poppins
wget -q --show-progress "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&display=swap" -O temp_poppins.css

# Extract font URLs from CSS
grep -o "https://fonts.gstatic.com/s/poppins/[^)]*" temp_poppins.css > poppins_urls.txt

# Download each font file
while read url; do
  wget -q --show-progress "$url" -O "assets/fonts/poppins/$(basename "$url")"
done < poppins_urls.txt

echo "Google Fonts downloaded successfully."

# Download Font Awesome
echo "Downloading Font Awesome 6.4.0..."
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" -O "assets/css/fontawesome.min.css"

# Modify Font Awesome CSS to use local webfonts
sed -i 's|../webfonts|../webfonts|g' "assets/css/fontawesome.min.css"

# Download Font Awesome webfonts
echo "Downloading Font Awesome webfonts..."
mkdir -p temp_webfonts
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-brands-400.woff2" -O "assets/webfonts/fa-brands-400.woff2"
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-regular-400.woff2" -O "assets/webfonts/fa-regular-400.woff2"
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-solid-900.woff2" -O "assets/webfonts/fa-solid-900.woff2"
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-v4compatibility.woff2" -O "assets/webfonts/fa-v4compatibility.woff2"

echo "Font Awesome downloaded successfully."

# Download Animate.css
echo "Downloading Animate.css..."
wget -q --show-progress "https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" -O "assets/css/animate.min.css"
echo "Animate.css downloaded successfully."

# Create custom Google Fonts CSS
echo "Creating custom Google Fonts CSS..."

cat > "assets/css/custom-fonts.css" << EOL
/* Playfair Display */
@font-face {
  font-family: 'Playfair Display';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('../fonts/playfair/v30-latin-regular.woff2') format('woff2');
}

/* Cormorant Garamond */
@font-face {
  font-family: 'Cormorant Garamond';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('../fonts/cormorant/v16-latin-regular.woff2') format('woff2');
}

@font-face {
  font-family: 'Cormorant Garamond';
  font-style: normal;
  font-weight: 600;
  font-display: swap;
  src: url('../fonts/cormorant/v16-latin-600.woff2') format('woff2');
}

@font-face {
  font-family: 'Cormorant Garamond';
  font-style: normal;
  font-weight: 700;
  font-display: swap;
  src: url('../fonts/cormorant/v16-latin-700.woff2') format('woff2');
}

/* Poppins */
@font-face {
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 300;
  font-display: swap;
  src: url('../fonts/poppins/v20-latin-300.woff2') format('woff2');
}

@font-face {
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('../fonts/poppins/v20-latin-regular.woff2') format('woff2');
}

@font-face {
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 500;
  font-display: swap;
  src: url('../fonts/poppins/v20-latin-500.woff2') format('woff2');
}
EOL

echo "Custom Google Fonts CSS created."

# Clean up temporary files
echo "Cleaning up temporary files..."
rm temp_playfair.css temp_cormorant.css temp_poppins.css
rm playfair_urls.txt cormorant_urls.txt poppins_urls.txt

echo "=== Setup Complete ==="
echo "Now update your header.njk file to reference the local assets."
echo "See the generated instructions in update-header-instructions.md"

# Create instructions file
cat > "update-header-instructions.md" << EOL
# How to Update Your Header File

Replace the external resource links in your \`header.njk\` file with these local versions:

## 1. Replace Font Awesome CDN

Replace this line:
\`\`\`html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
\`\`\`

With:
\`\`\`html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/fontawesome.min.css">
\`\`\`

## 2. Replace Google Fonts

Replace this line:
\`\`\`html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Playfair+Display&family=Poppins:wght@300;400;500&display=swap" rel="stylesheet">
\`\`\`

With:
\`\`\`html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/custom-fonts.css">
\`\`\`

## 3. Replace Animate.css CDN

Replace this line:
\`\`\`html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
\`\`\`

With:
\`\`\`html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/animate.min.css">
\`\`\`

## 4. Remove Preconnect Tags

You can remove these lines as they're no longer needed:
\`\`\`html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preconnect" href="https://cdnjs.cloudflare.com">
\`\`\`

## 5. Update Preload

Replace:
\`\`\`html
<link rel="preload" href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" as="style">
\`\`\`

With:
\`\`\`html
<link rel="preload" href="{{ assetsPath }}assets/css/custom-fonts.css" as="style">
\`\`\`
EOL

echo "Instructions file created: update-header-instructions.md"