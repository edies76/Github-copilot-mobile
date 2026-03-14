# Contributing to GitHub Copilot Mobile

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Please be respectful and inclusive in all interactions. We are committed to providing a welcoming and inspiring community for all.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/Github-copilot-mobile.git`
3. Add upstream remote: `git remote add upstream https://github.com/edies76/Github-copilot-mobile.git`
4. Create a feature branch: `git checkout -b feature/your-feature`

## Development Setup

See [DEVELOPMENT.md](DEVELOPMENT.md) for detailed setup instructions.

## Making Changes

### Code Style

- Follow Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### Commit Messages

Use clear, descriptive commit messages:

```
feat: Add new feature
fix: Fix bug in component
docs: Update documentation
style: Format code
test: Add tests for feature
refactor: Refactor component
```

### Pull Request Process

1. Update your branch with latest changes: `git pull upstream develop`
2. Make your changes and commit
3. Push to your fork: `git push origin feature/your-feature`
4. Open a pull request against the `develop` branch
5. Fill in the PR template with details about your changes
6. Wait for review and address feedback

## Testing

- Write tests for new features
- Ensure all tests pass: `flutter test`
- Aim for good code coverage

## Documentation

- Update README.md if adding new features
- Add inline comments for complex code
- Update DEVELOPMENT.md if changing setup process

## Reporting Issues

When reporting issues, please include:

- Clear description of the problem
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots if applicable
- Environment details (OS, Flutter version, etc.)

## Feature Requests

When suggesting features:

- Describe the use case
- Explain the expected behavior
- Provide examples if possible
- Consider implementation complexity

## Questions?

Feel free to open an issue or discussion for questions about the project.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing!
