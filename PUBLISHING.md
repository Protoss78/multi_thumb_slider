# Publishing Guide

This document provides step-by-step instructions for publishing the `multi_thumb_slider` package to pub.dev.

## Prerequisites

1. **Dart/Flutter SDK**: Ensure you have the latest stable version of Flutter installed
2. **pub.dev Account**: Create an account at [pub.dev](https://pub.dev) if you don't have one
3. **Google Account**: You'll need a Google account to sign in to pub.dev
4. **Package Verification**: Ensure your package passes all checks

## Pre-Publishing Checklist

Before publishing, verify that:

- [ ] All linting issues are resolved (`flutter analyze` passes)
- [ ] Package builds successfully on all platforms
- [ ] Tests pass (`flutter test`)
- [ ] Documentation is complete and accurate
- [ ] Example app works correctly
- [ ] Version number is appropriate
- [ ] All dependencies are properly specified

## Publishing Steps

### 1. Verify Package Structure

Ensure your package has the correct structure:

```
multi_thumb_slider/
├── lib/
│   ├── multi_thumb_slider.dart (main export file)
│   └── src/
│       └── multi_thumb_slider.dart (implementation)
├── example/
│   └── lib/
│       └── main.dart (example app)
├── test/ (if you have tests)
├── README.md
├── CHANGELOG.md
├── LICENSE
├── pubspec.yaml
└── analysis_options.yaml
```

### 2. Update Version Number

In `pubspec.yaml`, ensure the version is appropriate:

```yaml
version: 1.0.0+1  # For initial release
```

### 3. Run Final Checks

```bash
# Analyze the package
flutter analyze

# Run tests (if any)
flutter test

# Build the example
cd example
flutter build web
cd ..

# Verify package structure
flutter pub publish --dry-run
```

### 4. Publish to pub.dev

```bash
# Publish the package
flutter pub publish
```

You'll be prompted to:
1. Sign in with your Google account
2. Confirm the package details
3. Accept the terms of service

### 5. Verify Publication

After publishing:
1. Check [pub.dev](https://pub.dev/packages/multi_thumb_slider) for your package
2. Verify all documentation is displayed correctly
3. Test the installation in a new project

## Post-Publishing

### 1. Monitor Usage
- Check package analytics on pub.dev
- Monitor for any issues or feedback

### 2. Respond to Issues
- Address any reported bugs promptly
- Update documentation based on user feedback

### 3. Plan Updates
- Consider user feedback for future versions
- Plan feature additions and improvements

## Version Management

### Semantic Versioning
Follow [semantic versioning](https://semver.org/):

- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (1.1.0): New features, backward compatible
- **PATCH** (1.0.1): Bug fixes, backward compatible

### Updating Versions

1. Update `pubspec.yaml` version
2. Update `CHANGELOG.md`
3. Commit changes
4. Publish new version

## Troubleshooting

### Common Issues

1. **Package Name Conflict**: Ensure the package name is unique on pub.dev
2. **Dependency Issues**: Verify all dependencies are compatible
3. **Documentation Errors**: Check markdown syntax and links
4. **Build Failures**: Ensure the package builds on all target platforms

### Getting Help

- Check [pub.dev publishing documentation](https://dart.dev/tools/pub/publishing)
- Review [Flutter package publishing guide](https://flutter.dev/docs/deployment/publishing)
- Ask questions on [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter) or [Flutter Discord](https://discord.gg/flutter)

## Best Practices

1. **Documentation**: Write clear, comprehensive documentation
2. **Examples**: Provide working examples for common use cases
3. **Testing**: Include tests for your package functionality
4. **Maintenance**: Keep dependencies updated and address issues promptly
5. **Communication**: Respond to user feedback and issues

## Legal Considerations

- Ensure you have the right to publish the code
- Verify all dependencies have compatible licenses
- Include appropriate license information
- Respect intellectual property rights

## Support

For package-specific support:
- Create issues on the GitHub repository
- Respond to user questions and feedback
- Maintain active development and support
