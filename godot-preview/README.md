# Godot map/client preview

This folder is a small, standalone Godot 4 project for opening a local 3D map and testing a spawned first-person player. It deliberately does not start the repository's web site, API, database, asset service, or Roblox game server. The existing repository is left untouched; this is an isolated preview project rather than a destructive cleanup of the original source.

## Run

1. Install Godot 4.x.
2. In Godot, choose **Import** and select `godot-preview/project.godot`.
3. Press **F6** to run the current scene or **F5** to run the project.

## Controls

- **WASD**: move
- **Mouse**: look around
- **Space**: jump
- **Esc**: release the mouse; click the game window to capture it again

The map is a simple original blockout made from built-in primitives, so no asset downloads or project setup are needed. This is a local preview only; it does not load or emulate the original Roblox client or connect to its services.
