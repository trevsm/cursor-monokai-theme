# Publishing Cursor Monokai Theme for Cursor IDE

This guide explains how to publish the Cursor Monokai Theme so it's available in Cursor IDE's marketplace.

## Important Note

**Cursor IDE uses the Open VSX Registry** as its extension marketplace. To make your theme available in Cursor IDE, you must publish to **Open VSX Registry**.

## Prerequisites

1. **Open VSX Account**:
   - Visit https://open-vsx.org/
   - Sign up for an account (you can use GitHub to sign in)
   - Create a publisher profile
   - Note your publisher name/ID

2. **Personal Access Token (PAT)** from Open VSX:
   - Go to https://open-vsx.org/user-settings/namespaces
   - Create a namespace (publisher) if you haven't already
   - Go to https://open-vsx.org/user-settings/tokens
   - Create a new Personal Access Token
   - Save the token securely

3. **Install ovsx CLI** (Open VSX command-line tool):
   ```bash
   npm install -g ovsx
   ```

4. **Install vsce** (for packaging the extension):
   ```bash
   npm install -g @vscode/vsce
   ```

## Publishing Steps

### Publish to Open VSX Registry (Required for Cursor)

1. **Update package.json** (if needed):
   - Ensure the `"publisher"` field matches your Open VSX publisher name
   - Update version number if needed

2. **Package the extension**:
   ```bash
   cd cursor-monokai-theme
   vsce package
   ```
   This creates a `.vsix` file.

3. **Publish to Open VSX Registry**:
   ```bash
   ovsx publish -p <your-personal-access-token>
   ```
   Replace `<your-personal-access-token>` with the token from your Open VSX account.
   
   Or you can publish interactively:
   ```bash
   ovsx publish
   ```
   You'll be prompted for your Personal Access Token.

4. **Verify**:
   - Check https://open-vsx.org/extension/YOUR_PUBLISHER/cursor-monokai-theme
   - The theme will be available in Cursor IDE's Extensions view within a few minutes
   - Users can search for "Cursor Monokai Theme" in Cursor's Extensions view


## Testing Locally in Cursor

Before publishing, you can test the theme locally:

1. Package the extension:
   ```bash
   vsce package
   ```

2. In Cursor IDE:
   - Open Extensions view (Ctrl+Shift+X)
   - Click "..." → "Install from VSIX..."
   - Select the generated `.vsix` file
   - Reload Cursor
   - Open Command Palette (Ctrl+Shift+P)
   - Type "Color Theme" and select "Cursor Monokai"

## Updating the Extension

To publish an update:

1. Update the version in `package.json` (following semantic versioning)
2. Update `CHANGELOG.md` with the changes
3. Package the extension: `vsce package`
4. Publish to Open VSX: `ovsx publish -p <your-token>`

## Notes

- The theme is optimized for Cursor IDE
- Cursor users can install it directly from the Extensions view by searching "Cursor Monokai Theme"
- The theme is designed specifically for Cursor IDE's interface and features

## Troubleshooting

- **"Publisher not found"**: Make sure you've created a namespace/publisher at https://open-vsx.org/user-settings/namespaces
- **"Invalid token"**: Regenerate your Personal Access Token at https://open-vsx.org/user-settings/tokens
- **"Extension already exists"**: If the extension ID already exists, you'll need to use a different publisher name or contact the original publisher
- **"ovsx: command not found"**: Make sure you've installed ovsx globally: `npm install -g ovsx`

