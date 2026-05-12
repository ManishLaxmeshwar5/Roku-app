# POC Latest Deeplinking

Roku streaming application built using SceneGraph and BrightScript with MVVM architecture support.

## Features

- Video playback
- Deep linking support
- MVVM architecture
- Row and carousel based UI
- Bookmark functionality
- GitHub Actions workflow
- PR template integration

## Project Structure

```bash
components/   -> SceneGraph components, BrightScript files
source/       -> main.brs
images/       -> Application assets
manifest      -> Roku app configuration
.github/      -> GitHub workflows and PR templates
```

## Build Application

Run:

```bash
make build
```

This creates:

```bash
POC.zip
```

## Clean Build Files

```bash
make clean
```

## Technologies Used

- BrightScript
- Roku SceneGraph
- GitHub Actions
- MVVM Architecture

## Author

Manish Kumar