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
      uses: k0gen/sdk@main
```

This will run the StartOS SDK action, which sets up the package development environment, installs start-sdk, and includes tools like yq and deno as part of your GitHub workflow.

Please note that this action must be run on a runner that supports sudo, snap, and Docker, such as ubuntu-latest.

## Real-world Examples
Here are some real-world examples of how this action can be used in a workflow:

[Synapse for StartOS](https://github.com/Start9Labs/synapse-startos): This repository uses a similar GitHub Action in its workflow to build the Synapse service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/synapse-startos/blob/master/.github/workflows/buildService.yml).

[Jellyfin for StartOS](https://github.com/Start9Labs/jellyfin-startos): This repository uses a similar GitHub Action in its workflow to build the Jellyfin service for StartOS. You can check out the workflow file [here](https://github.com/Start9Labs/jellyfin-startos/blob/master/.github/workflows/buildService.yml).

These examples should give you a good idea of how to structure your own workflows using the StartOS SDK GitHub Action. Remember, the key is to adapt and modify the workflow to suit the specific needs of your project. Happy service packaging! 😊