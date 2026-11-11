# 🔎 Documentation validation — final

[🏠 Documentation home](index.md)

Validation resolves documentation links in the documentation folder **plus the latest server ZIP and PlayerControl drop-in overlay**. Source references are verified by their SHA-256 against those archive bytes.

| Check | Result |
|---|---:|
| Centralized Markdown files | 431 |
| Relative document/file links checked | 3341 |
| Unresolved file paths | 0 |
| Source-reference pages verified against ZIP SHA | 232 |
| Historical source reference pages (not in latest ZIP) | 58 |
| Current-source references regenerated for changed files | 72 |
| New PlayerControl and migrated source references | 19 |

## Important limits

- This check resolves local file paths. It does not validate every heading anchor or claim runtime behavior.
- Historical references are preserved with visible warnings rather than silently represented as current source.
- Existing tests use mocked Net APIs and are not substitutes for a running server.
- Original authored READMEs outside `_DOCUMENTATION` remain in documentation-only installation unless removed manually or using the integrated full-server ZIP.
