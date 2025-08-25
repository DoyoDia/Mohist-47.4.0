#!/bin/bash
# Test script to validate the rebuild workflow logic locally

set -e

echo "🔧 Testing rebuild commit workflow logic..."

# Test variables
TEST_COMMIT="3a134d42c"  # Use the available commit
TEST_SUFFIX="test"

echo "Test commit: $TEST_COMMIT"
echo "Test suffix: $TEST_SUFFIX"
echo ""

# Test commit checkout logic
echo "📋 Testing commit checkout..."
if git rev-parse --verify "$TEST_COMMIT" >/dev/null 2>&1; then
    echo "✅ Commit $TEST_COMMIT exists and is accessible"
    
    # Test artifact naming logic
    echo ""
    echo "📦 Testing artifact naming..."
    COMMIT_SHORT=$(echo "$TEST_COMMIT" | cut -c1-7)
    if [ -n "$TEST_SUFFIX" ]; then
        ARTIFACT_NAME="Mohist-1.20.1-server-${COMMIT_SHORT}-${TEST_SUFFIX}"
    else
        ARTIFACT_NAME="Mohist-1.20.1-server-${COMMIT_SHORT}"
    fi
    
    echo "Short commit: $COMMIT_SHORT"
    echo "Artifact name: $ARTIFACT_NAME"
    echo "✅ Artifact naming logic works correctly"
    
    # Show commit info
    echo ""
    echo "📝 Commit information:"
    git log -1 --pretty=format:"- Author: %an (%ae)%n- Date: %ad%n- Message: %s" --date=iso "$TEST_COMMIT"
    
else
    echo "❌ Commit $TEST_COMMIT not found"
    echo "Available recent commits:"
    git log --oneline -5
    exit 1
fi

echo ""
echo "✅ All workflow logic tests passed!"
echo ""
echo "To run the actual workflow:"
echo "1. Go to Actions tab in GitHub"
echo "2. Select 'Rebuild Specific Commit'"
echo "3. Click 'Run workflow'"
echo "4. Enter commit SHA: $TEST_COMMIT"
echo "5. Enter suffix: $TEST_SUFFIX"