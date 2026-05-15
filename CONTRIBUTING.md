# Contributing to Onion System

First off, thank you for considering contributing to Onion! 🧅

This document provides guidelines for contributing to the Onion v4.0 Multi-Context Development Orchestrator.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Community](#community)

---

## 📜 Code of Conduct

This project adheres to a Code of Conduct. By participating, you are expected to uphold this code.

### Our Standards

- **Be Respectful**: Treat everyone with respect
- **Be Collaborative**: Work together constructively
- **Be Inclusive**: Welcome diverse perspectives
- **Be Professional**: Maintain professionalism in all interactions

---

## 🚀 Getting Started

### Prerequisites

- Node.js >= 16.0.0
- pnpm (recommended) or npm
- Git
- Claude Code (recommended for testing)

### Quick Start

```bash
# 1. Fork and clone the repository
git clone https://github.com/your-username/onion-v4.git
cd onion-v4

# 2. Open in Claude Code (or another supported IDE)
#    O Sistema Onion vive em .claude/ — comandos e agentes carregam automaticamente.
```

---

## 🛠️ Development Setup

### Project Structure

```
onion-claude/
├── .claude/                # Sistema Onion operacional (comandos, agentes, regras)
│   ├── commands/           # Comandos organizados por categoria
│   ├── agents/             # Agentes especializados por domínio
│   ├── rules/              # Regras e convenções
│   └── utils/              # Utilitários (incl. task-manager abstraction)
├── docs/                   # Documentação
│   ├── meta-specs/         # Spec as Code (L0 — constituição)
│   ├── knowledge-base/           # Knowledge bases estruturadas
│   └── onion/              # Guias e referências
└── CLAUDE.md               # Project rules carregados pelo Claude Code
```

---

## 🤝 How to Contribute

### Types of Contributions

We welcome the following types of contributions:

#### 🐛 Bug Reports
- Use GitHub Issues
- Include: version, command executed, error message, expected behavior
- Provide minimal reproduction steps

#### ✨ Feature Requests
- Use GitHub Discussions
- Describe the problem you're solving
- Explain your proposed solution
- Consider backward compatibility

#### 📚 Documentation
- Fix typos
- Improve clarity
- Add examples
- Translate to other languages

#### 💻 Code Contributions
- Bug fixes
- New features
- Performance improvements
- Test coverage improvements

---

## 🔀 Pull Request Process

### 1. Create a Feature Branch

```bash
# From main branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/bug-description
```

### 2. Make Your Changes

- Follow [Coding Standards](#coding-standards)
- Add tests for new features
- Update documentation as needed
- Keep commits atomic and descriptive

### 3. Commit Your Changes

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Feature
git commit -m "feat(cli): add support for Windsurf IDE"

# Bug fix
git commit -m "fix(migrator): correct symlink paths on Windows"

# Documentation
git commit -m "docs(readme): update installation instructions"

# Tests
git commit -m "test(core): add validator tests for context names"

# Refactoring
git commit -m "refactor(generator): extract method for IDE loader generation"
```

**Commit message format**:
```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Tests
- `refactor`: Code refactoring
- `style`: Formatting
- `chore`: Maintenance
- `perf`: Performance

### 4. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- **Clear title** following conventional commits
- **Description** of what changed and why
- **Related issues** (e.g., "Fixes #123")
- **Screenshots** (if UI changes)
- **Breaking changes** (if any)

### 5. PR Review Process

- All PRs require at least 1 approval
- CI must pass (tests, linting)
- Address review comments
- Keep PR scope focused (single responsibility)

---

## 📏 Coding Standards

### JavaScript/Node.js

#### ES6 Modules
```javascript
// ✅ Good
import fs from 'fs-extra';
export function myFunction() { }

// ❌ Bad
const fs = require('fs-extra');
module.exports = { myFunction };
```

#### Naming Conventions
```javascript
// ✅ Good
const userName = 'John';
function getUserById(id) { }
class UserProfile { }

// ❌ Bad
const user_name = 'John';
function get_user_by_id(id) { }
class user_profile { }
```

#### Function Size
- Keep functions < 50 lines
- Single responsibility principle
- Extract complex logic to separate functions

#### Comments
```javascript
/**
 * Brief description of function
 * 
 * @param {string} userId - User ID
 * @returns {Promise<User>} User object
 */
async function getUser(userId) {
  // Implementation comment (in Portuguese for Onion project)
  // Busca usuário no banco de dados
}
```

### Onion-Specific Standards

#### Command Files (Markdown)
```yaml
---
name: command-name
description: Brief description
model: sonnet
category: business|technical|core
tags: [tag1, tag2]
version: "4.0.0"
updated: "YYYY-MM-DD"
level: starter|intermediate|advanced
context: business|technical|core
---
```

#### Agent Files (Markdown)
```yaml
---
name: agent-name
description: Agent specialization
model: sonnet
category: business|technical|meta
tags: [tag1, tag2]
expertise: [area1, area2]
version: "4.0.0"
updated: "YYYY-MM-DD"
context: business|technical|core
---
```

---

## 🧪 Testing Guidelines

### Test Structure

```javascript
describe('Module Name', () => {
  beforeEach(() => {
    // Setup
  });

  afterEach(() => {
    // Cleanup
  });

  test('should do something specific', () => {
    // Arrange
    const input = 'test';
    
    // Act
    const result = myFunction(input);
    
    // Assert
    expect(result).toBe('expected');
  });
});
```

### Coverage Goals

- **Core modules**: 90%+ coverage
- **Commands**: 70%+ coverage
- **Utilities**: 80%+ coverage

### Test Types

1. **Unit Tests**: Test individual functions
2. **Integration Tests**: Test module interactions
3. **E2E Tests**: Test complete workflows (future)

---

## 📚 Documentation

### What to Document

- **New features**: How to use, examples
- **Breaking changes**: Migration guide
- **Complex logic**: Inline comments
- **APIs**: JSDoc for all public functions

### Documentation Locations

- `docs/` - User-facing documentation
- `README.md` - Project overview
- `CHANGELOG.md` - Version history
- `.claude/sessions/` - Development sessions
- Inline JSDoc - Code documentation

### Documentation Style

- **Language**: English for code, Portuguese for comments/docs (Onion convention)
- **Format**: Markdown
- **Examples**: Always include practical examples
- **Code blocks**: Use syntax highlighting

---

## 🌍 Community

### Communication Channels

- **GitHub Issues**: Bug reports, feature requests
- **GitHub Discussions**: Questions, ideas, general discussion
- **Discord**: Real-time chat (coming soon)

### Getting Help

- Check existing issues and discussions first
- Provide detailed information when asking questions
- Be patient and respectful

### Recognition

Contributors will be recognized in:
- `CONTRIBUTORS.md` file
- Release notes
- Project documentation

---

## 🏆 Recognition Levels

### 🥉 Contributor
- 1+ merged PR

### 🥈 Regular Contributor
- 5+ merged PRs
- Consistent quality contributions

### 🥇 Core Contributor
- 20+ merged PRs
- Significant feature contributions
- Help with code reviews

---

## 📝 Checklist for Contributors

Before submitting a PR, ensure:

- [ ] Code follows project standards
- [ ] Tests added/updated (if applicable)
- [ ] All tests pass locally
- [ ] Documentation updated (if applicable)
- [ ] Commit messages follow conventional commits
- [ ] PR description is clear and complete
- [ ] No breaking changes (or documented if yes)
- [ ] Changelog updated (for significant changes)

---

## 🔗 Useful Links

- [Onion v4 Epic](docs/plans/onion-v4-epic.md)
- [Release Notes](docs/onion/RELEASE-NOTES-v4.0-beta.md)
- [Level System Guide](docs/onion/levels-system.md)
- [CLI Implementation](docs/onion/cli-implementation-complete.md)

---

## ❓ Questions?

If you have questions about contributing:

1. Check existing documentation
2. Search GitHub Issues
3. Ask in GitHub Discussions
4. Join our Discord (coming soon)

---

**Thank you for contributing to Onion! 🧅🚀**

Your contributions help make development more efficient and enjoyable for everyone.

---

**Last updated**: 2025-12-20  
**Version**: 1.0.0

