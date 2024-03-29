# StartOS SDK GitHub Action

This GitHub Action, defined in `action.yaml`, provides `start-sdk` and `start-cli` for packaging services for StartOS. It sets up the necessary dependencies, Rust, QEMU, Docker Buildx, and checks out the `start-os` repository. It also caches `start-sdk` and installs it if it's not already present. Additionally, it includes tools like `yq` and `deno`. Think of it as a remote build environment for your StartOS services.

## Usage

To use this action in your GitHub workflow, you can refer to it in your workflow file (`*.yml` or `*.yaml` in your `.github/workflows` directory).

Here's a basic example:

```yaml
name: Build My Service
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Use StartOS SDK
      uses: Start9Labs/sdk@v1
```

This will run the StartOS SDK action, which sets up the package development environment, installs start-sdk, and includes tools like yq and deno as part of your GitHub workflow.

Please note that this action must be run on a runner that supports sudo, snap, and Docker, such as ubuntu-latest.

## Drop-in Workflows

This repository introduces a series of drop-in workflows designed to simplify the development process and ensure consistency and quality across all services. These workflows can be easily integrated into any service repository and will automate various stages of the development process.

### [buildService.yml](buildService.yml)

The `buildService.yml` workflow is a universal build service that provides a standardized way to build StartOS packages. Once integrated, it will automatically trigger a Continuous Integration (CI) build on every commit or Pull Request (PR), eliminating the need for manual build triggers and saving valuable time and effort.

### [releaseService.yml](releaseService.yml)

The `releaseService.yml` workflow automates the release process of your service.
Releasing a new version of your service is as simple as:

```bash
git tag v0.0.1
git push origin v0.0.1
```

Make sure to change `v0.0.1` accordingly to your service version. This will automatically trigger a package build based on the version tag. It will also automatically take the package’s manifest.yaml release-notes and compose a release message from it. In addition, it will build the `s9pk` package, generate a sha256 sum hash for the package inside the release note, and create a `.sha256` file.

> This workflow includes a "Publish to Registry" step. To utilize this feature, ensure you've set the required registry credentials (`S9USER`, `S9PASS`, `S9REGISTRY`) as registry secrets. **When setting up the `S9REGISTRY` secret, make sure you enter the registry address in the format `your-registry.example.com`. Do not include `https://` or any trailing `/`, just the plain address.** If any credentials are missing, the workflow will gracefully skip the publish step.

These workflows are designed to make the development and release process for your services as smooth and efficient as possible.

## Real-world Examples
Here are some real-world examples of how this action can be used in a workflow:

[Synapse for StartOS](https://github.com/Start9Labs/synapse-startos): This repository uses a similar GitHub Action in its workflow to build the Synapse service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/synapse-startos/blob/master/.github/workflows/buildService.yml).

[Jellyfin for StartOS](https://github.com/Start9Labs/jellyfin-startos): This repository uses a similar GitHub Action in its workflow to build the Jellyfin service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/jellyfin-startos/blob/master/.github/workflows/buildService.yml).

These examples should give you a good idea of how to structure your own workflows using the StartOS SDK GitHub Action. Remember, the key is to adapt and modify the workflow to suit the specific needs of your project. Happy service packaging! 😊