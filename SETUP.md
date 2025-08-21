# GitHub Actions & Pages Setup Guide

This guide will help you set up the GitHub Actions workflow and GitHub Pages for your Flutter project.

## 🚀 What This Setup Provides

- **Automated Testing**: Runs tests on every push and pull request
- **Code Quality Checks**: Analyzes code and checks formatting
- **Example App Building**: Builds the web version of your example app
- **Live Demo**: Hosts the example app on GitHub Pages
- **Automatic Deployment**: Updates the live demo whenever you push to main/master

## 📋 Prerequisites

1. Your repository must be public (or you need GitHub Pro for private repos with GitHub Pages)
2. GitHub Actions must be enabled for your repository
3. GitHub Pages must be enabled for your repository

## ⚙️ Step-by-Step Setup

### 1. Enable GitHub Actions

1. Go to your repository on GitHub
2. Click on the **Actions** tab
3. Click **Enable Actions** if prompted

### 2. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on **Settings**
3. Scroll down to **Pages** in the left sidebar
4. Under **Source**, select **GitHub Actions**
5. Click **Save**

### 3. Update Repository Settings

1. In the same **Settings** page, go to **Actions** → **General**
2. Under **Workflow permissions**, select **Read and write permissions**
3. Check **Allow GitHub Actions to create and approve pull requests**
4. Click **Save**

### 4. Update the README Link

The workflow will deploy your example to:
```
https://yourusername.github.io/multi_thumb_slider/
```

**Important**: Update the link in `README.md` to match your actual GitHub username and repository name.

### 5. Push Your Changes

```bash
git add .
git commit -m "Add GitHub Actions workflow and Pages setup"
git push origin main
```

## 🔄 How It Works

1. **On Push/PR**: The workflow automatically runs tests and builds
2. **On Main Branch**: After successful tests, the example app is deployed to GitHub Pages
3. **Live Demo**: Your example app becomes available at the GitHub Pages URL

## 📁 Workflow Files Created

- `.github/workflows/ci-cd.yml` - Main CI/CD pipeline
- `.github/workflows/deploy.yml` - GitHub Pages deployment
- `.github/workflows/pages.yml` - Alternative deployment workflow

## 🐛 Troubleshooting

### Workflow Not Running
- Check if GitHub Actions is enabled
- Verify the workflow files are in `.github/workflows/`
- Check the Actions tab for any error messages

### Build Failures
- Ensure your Flutter version is compatible (3.19.0+)
- Check that all dependencies are properly specified
- Verify the example app builds locally

### Pages Not Deploying
- Ensure GitHub Pages is enabled and set to "GitHub Actions"
- Check workflow permissions in repository settings
- Verify the deployment workflow runs after successful CI

### Example App Not Loading
- Check the GitHub Pages URL in your repository settings
- Verify the build artifacts are being uploaded correctly
- Check the Actions logs for deployment errors

## 🔧 Customization

### Change Flutter Version
Update the `flutter-version` in all workflow files:
```yaml
flutter-version: '3.19.0'  # Change this to your preferred version
```

### Modify Build Commands
Edit the build steps in the workflow files to customize the build process.

### Add More Tests
Add additional testing steps in the `test` job of `ci-cd.yml`.

## 📞 Support

If you encounter issues:
1. Check the Actions tab for detailed logs
2. Verify all prerequisites are met
3. Check GitHub's documentation on Actions and Pages
4. Ensure your Flutter project structure matches the workflow expectations

## 🎉 Success!

Once everything is set up:
- Your tests will run automatically on every push
- Your example app will be built and deployed
- Users can interact with your widget in the live demo
- The README will link to the working example

The live demo will showcase your multi-thumb slider widget and help users understand how to use it!