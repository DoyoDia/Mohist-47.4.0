# Rebuild Specific Commit Workflow

This repository includes a GitHub Action workflow that allows you to rebuild any specific commit of the Mohist server.

## How to Use

1. **Navigate to the Actions tab** in the GitHub repository
2. **Select "Rebuild Specific Commit"** from the workflow list
3. **Click "Run workflow"** button
4. **Fill in the parameters:**
   - **Commit SHA**: Enter the commit hash you want to rebuild (e.g., `95dd6ec`)
   - **Artifact name suffix** (optional): Add a custom suffix to distinguish your build
   - **Fetch from upstream**: Whether to fetch from the main MohistMC repository

5. **Click "Run workflow"** to start the build

## Example Use Cases

### Rebuilding the PlayerPickItemEvent Fix
To rebuild commit `95dd6ec` which adds the PlayerPickItemEvent fix:

```
Commit SHA: 95dd6ec
Artifact name suffix: player-pick-fix
```

This will create an artifact named: `Mohist-1.20.1-server-95dd6ec-player-pick-fix`

### Testing Historical Builds
You can rebuild any historical commit to test compatibility or specific features:

```
Commit SHA: abc123d
Artifact name suffix: test-build
```

## Build Process

The workflow performs the following steps:

1. **Checkout**: Downloads the repository with full history
2. **Fetch upstream**: Optionally fetches from the main MohistMC repository
3. **Commit checkout**: Switches to the specified commit
4. **Java setup**: Configures JDK 17
5. **Gradle setup**: Runs `./gradlew setup packageLibraries`
6. **Build**: Runs `./gradlew mohistJar`
7. **Upload**: Creates a downloadable artifact with the built server jar

## Troubleshooting

### Common Issues

- **Commit not found**: Ensure the commit exists and try enabling "Fetch from upstream"
- **Build failures**: Some older commits may have dependency issues or require different build configurations
- **Network timeouts**: The workflow includes retry logic for network-related failures

### Getting Build Logs

If a build fails, check the workflow run logs in the Actions tab for detailed error messages and troubleshooting information.

## Artifact Download

Once the workflow completes successfully:

1. Go to the workflow run page
2. Scroll down to the "Artifacts" section
3. Click on your artifact to download the built server jar

The downloaded jar can be used as a Mohist server by running:
```bash
java -jar mohist-1.20.1-[commit]-server.jar
```