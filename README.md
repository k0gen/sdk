# StartOS SDK GitHub Action

This GitHub Action, defined in `action.yaml`, provides `start-cli` for packaging services for StartOS. It sets up the necessary dependencies, Rust, QEMU, Docker, and Docker Buildx to create a complete build environment for StartOS services.

## Features

- Sets up Node.js 22
- Installs minimal required dependencies (build-essential, clang, libclang-dev, squashfs-tools-ng, qemu-user-static)
- Configures Rust toolchain
- Sets up QEMU for multi-architecture builds
- Configures Docker and Docker Buildx
- Installs the latest version of `start-cli`

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
        uses: actions/checkout@v4

      - name: Use StartOS SDK
        uses: start9labs/sdk@v2
```

This will run the StartOS SDK action, which sets up the package development environment and installs start-cli as part of your GitHub workflow.

Please note that this action must be run on a runner that supports sudo and Docker, such as ubuntu-latest.

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

Make sure to change `v0.0.1` accordingly to your service version. This will automatically trigger a package build based on the version tag. It will also automatically take the package's manifest.yaml release-notes and compose a release message from it. In addition, it will build the `s9pk` package, generate a sha256 sum hash for the package inside the release note, and create a `.sha256` file.

> This workflow includes a "Publish to Registry" step. To utilize this feature, ensure you've set the required registry credentials as GitHub secrets:
>
> - `S9DEVKEY`: Your StartOS developer private key (the entire key including BEGIN and END lines). This key is typically found at `~/.startos/developer.key.pem` on your local development machine. The content should look like:
>
>   ```
>   -----BEGIN PRIVATE KEY-----
>   MFECAQEwBQYDK2VwBCIEICpqAbMjPAY9mwepR6GRACtYkWvGVxh0TePJdF3m2apY
>   gSEAK1DVeOiw6/M4Ss6kS65PvPMopKL/tF6fIJPhTQ8MO2Q=
>   -----END PRIVATE KEY-----
>   ```
>
>   > 💡 **Tip for macOS users**: You can easily copy the key to your clipboard by running `pbcopy < ~/.startos/developer.key.pem` in your terminal.
>
> - `S9REGISTRY`: The registry address in the format `your-registry.example.com` (do not include `https://` or any trailing `/`)
>
> The workflow uses key-based authentication with the registry. If any credentials are missing, the workflow will gracefully skip the publish step.

These workflows are designed to make the development and release process for your services as smooth and efficient as possible.

## Real-world Examples

Here are some real-world examples of how this action can be used in a workflow:

[Synapse for StartOS](https://github.com/Start9Labs/synapse-startos): This repository uses a similar GitHub Action in its workflow to build the Synapse service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/synapse-startos/blob/master/.github/workflows/buildService.yml).

[Jellyfin for StartOS](https://github.com/Start9Labs/jellyfin-startos): This repository uses a similar GitHub Action in its workflow to build the Jellyfin service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/jellyfin-startos/blob/master/.github/workflows/buildService.yml).

These examples should give you a good idea of how to structure your own workflows using the StartOS SDK GitHub Action. Remember, the key is to adapt and modify the workflow to suit the specific needs of your project. Happy service packaging! 😊
