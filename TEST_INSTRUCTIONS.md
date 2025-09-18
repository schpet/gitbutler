# GitButler Command-Line Repository Opening - Test Instructions

## What's Been Implemented

I've implemented the ability to open GitButler with a repository path as a command-line argument. The implementation includes:

1. **Initial app launch**: When GitButler is launched with a repository path, it will automatically open that repository
2. **App already running**: When GitButler is already running and you try to open it with a different repository, it will open the new repository in a new window (similar to command-clicking on a project)

## Building the Application

To build GitButler with the new feature:

```bash
# Build the application in release mode
pnpm tauri build

# Or for development/testing (faster):
pnpm tauri dev:desktop
```

The built application will be in:
- macOS: `target/release/bundle/macos/GitButler.app`
- For development: `target/debug/bundle/macos/GitButler Dev.app`

## Testing Commands

### macOS (using the `open` command)

Once the app is built, you can test it with these commands:

#### 1. Open with current directory (most common use case):
```bash
# Navigate to a git repository
cd ~/code/some-repo

# Open GitButler with current directory
open -a '/Applications/GitButler.app' --args .
```

#### 2. Open with absolute path:
```bash
open -a '/Applications/GitButler.app' --args /Users/schpet/code/gitbutler
```

#### 3. Open with relative path:
```bash
open -a '/Applications/GitButler.app' --args ../another-repo
```

#### 4. Test opening a new window (when app is already running):
```bash
# First, open GitButler with one repository
open -a '/Applications/GitButler.app' --args ~/code/repo1

# Then open another repository (should open in new window)
open -a '/Applications/GitButler.app' --args ~/code/repo2
```

### For Development Testing

If you're using the development build:

```bash
# Using pnpm tauri dev (pass arguments after double dashes)
pnpm tauri dev -- -- /path/to/repository

# Or if you have the dev app built
open -a '/path/to/GitButler Dev.app' --args /path/to/repository
```

## Expected Behavior

1. **Valid Git Repository**: The path must point to a valid git repository (contains `.git` directory)
2. **New Instance**: If GitButler isn't running, it will launch and open the specified repository
3. **Existing Instance**: If GitButler is already running with a different project, it will open a new window with the specified repository
4. **Invalid Path**: If the path is not a git repository or doesn't exist, GitButler will launch normally without opening any specific project

## Implementation Details

The feature works by:
1. Parsing command-line arguments in the Tauri backend (Rust)
2. Checking if the provided path is a valid git repository
3. Emitting events to the frontend
4. Frontend handles the event by:
   - Adding the project if it's not already added
   - Opening it in the same window (first launch) or new window (already running)

## Notes

- The `--args` flag is required on macOS when using the `open` command
- The path argument should come after `--args`
- Only the first valid repository path is processed (if multiple are provided)