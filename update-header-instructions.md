# How to Update Your Header File

Replace the external resource links in your `header.njk` file with these local versions:

## 1. Replace Font Awesome CDN

Replace this line:
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
```

With:
```html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/fontawesome.min.css">
```

## 2. Replace Google Fonts

Replace this line:
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Playfair+Display&family=Poppins:wght@300;400;500&display=swap" rel="stylesheet">
```

With:
```html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/custom-fonts.css">
```

## 3. Replace Animate.css CDN

Replace this line:
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
```

With:
```html
<link rel="stylesheet" href="{{ assetsPath }}assets/css/animate.min.css">
```

## 4. Remove Preconnect Tags

You can remove these lines as they're no longer needed:
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preconnect" href="https://cdnjs.cloudflare.com">
```

## 5. Update Preload

Replace:
```html
<link rel="preload" href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" as="style">
```

With:
```html
<link rel="preload" href="{{ assetsPath }}assets/css/custom-fonts.css" as="style">
```
