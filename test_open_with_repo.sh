#!/bin/bash

# Test script to demonstrate opening GitButler with a repository path

echo "GitButler Command-Line Repository Opening Test"
echo "=============================================="
echo ""

# Get the current directory as an example repository
REPO_PATH="$PWD"

echo "This script demonstrates how to open GitButler with a repository path."
echo ""
echo "Example 1: Using absolute path with --args flag (standard macOS approach):"
echo "  open -a '/Applications/GitButler.app' --args '$REPO_PATH'"
echo ""
echo "Example 2: Using relative path (current directory):"
echo "  open -a '/Applications/GitButler.app' --args ."
echo ""
echo "Example 3: Using a specific repository path:"
echo "  open -a '/Applications/GitButler.app' --args ~/code/my-project"
echo ""
echo "Note: The repository path must be a valid git repository (contains .git directory)"
echo ""
echo "For development testing with pnpm tauri dev:"
echo "  pnpm tauri dev -- -- '$REPO_PATH'"
echo ""
echo "The implementation will:"
echo "1. Check if the path is a valid directory"
echo "2. Verify it contains a .git directory"
echo "3. Add the project to GitButler"
echo "4. Navigate to the newly added project"
echo "5. Focus the GitButler window"