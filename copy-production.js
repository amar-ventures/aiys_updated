const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const outputDir = path.resolve(__dirname, '_site');
const projectRoot = __dirname;

// Check if _site directory exists
if (!fs.existsSync(outputDir)) {
  console.error('Error: _site directory does not exist. Run build first.');
  process.exit(1);
}

console.log('Copying _site contents to project root...');

// Create file copier function
const copyFiles = (src, dest) => {
  const entries = fs.readdirSync(src, { withFileTypes: true });

  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    // Skip copying the _site directory to root
    if (entry.name === '_site') continue;

    // Copy directories and files
    if (entry.isDirectory()) {
      fs.mkdirSync(destPath, { recursive: true });
      copyFiles(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
};

// Remove directory recursively function (safer than rm -rf)
const removeDirectory = (directory) => {
  return new Promise((resolve, reject) => {
    console.log(`Removing directory: ${directory}`);
    exec(`rm -rf "${directory}"`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error removing directory: ${error.message}`);
        reject(error);
        return;
      }
      if (stderr) {
        console.error(`Error output: ${stderr}`);
      }
      resolve();
    });
  });
};

// Main execution
(async () => {
  try {
    // Step 1: Copy all files from _site to project root
    copyFiles(outputDir, projectRoot);
    console.log('Production copy completed successfully');
    
    // Step 2: Remove _site directory after copying
    await removeDirectory(outputDir);
    console.log('_site directory removed successfully');
    
    console.log('Deployment preparation complete!');
  } catch (error) {
    console.error('Operation failed:', error);
    process.exit(1);
  }
})();