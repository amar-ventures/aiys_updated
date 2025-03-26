document.addEventListener('DOMContentLoaded', () => {
  const menuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');

  if (!menuButton || !mobileMenu) {
    console.error('Mobile menu elements not found:', { menuButton, mobileMenu });
    return;
  }

  // Ensure mobile menu is hidden initially
  mobileMenu.classList.add('hidden');

  // Toggle mobile menu on button click
  menuButton.addEventListener('click', (e) => {
    e.stopPropagation();
    mobileMenu.classList.toggle('hidden');

    if (!mobileMenu.classList.contains('hidden')) {
      // Add positioning/styling when shown
      mobileMenu.classList.add('fixed', 'top-16', 'left-0', 'right-0', 'bg-white', 'shadow-md', 'z-40');

      // Optionally animate each menu link
      const menuItems = mobileMenu.querySelectorAll('a');
      menuItems.forEach((item, index) => {
        item.style.opacity = '0';
        setTimeout(() => {
          item.style.transition = 'opacity 0.3s ease';
          item.style.opacity = '1';
        }, index * 100);
      });
    } else {
      mobileMenu.classList.remove('fixed', 'top-16', 'left-0', 'right-0');
    }
  });

  // Hide mobile menu when clicking outside
  document.addEventListener('click', (e) => {
    if (!mobileMenu.contains(e.target) && !menuButton.contains(e.target)) {
      mobileMenu.classList.add('hidden');
      mobileMenu.classList.remove('fixed', 'top-16', 'left-0', 'right-0');
    }
  });

  // Hide mobile menu on resize if width is ≥1024 (desktop view)
  window.addEventListener('resize', () => {
    if (window.innerWidth >= 1024) {
      mobileMenu.classList.add('hidden');
      mobileMenu.classList.remove('fixed', 'top-16', 'left-0', 'right-0');
    }
  });
});