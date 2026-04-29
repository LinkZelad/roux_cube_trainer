# Roux Bridge Trainer

A modern, visually-rich 3D training application for the **Roux Method** of solving the Rubik's Cube. Built with Flutter and embedded 3D web technologies to provide a seamless cross-platform practice experience.

![Roux Trainer Preview](https://github.com/LinkZelad/roux_cube_trainer/raw/master/docs/images/preview.png) *(Note: Placeholder image link)*

## 🚀 Features

- **Full Roux Workflow Support**: Specialized practice modules for:
  - **FB (First Block)**: Efficient 1x2x3 block building.
  - **SB (Second Block)**: Right side 1x2x3 block building while preserving FB.
  - **CMLL (Corners of the Last Layer)**: All 42 orientation and permutation cases.
  - **LSE (Last Six Edges)**: EO, LR placement, and 4C permutation.
- **Interactive 3D Cube**:
  - **Free Rotation**: Drag to rotate the cube and inspect it from any angle.
  - **Ghost Faces (Mirror Views)**: Real-time 2D projections of hidden faces (Back, Left, Bottom) to eliminate blind spots.
  - **Animated Playback**: Step-by-step playback of optimal algorithms with smooth 3D transitions.
- **High-Quality Algorithms**: Solutions sourced from community experts and standard Roux tutorials (Cuberoot, Kian Mansour, Onionhoney).
- **Offline Friendly**: Core training logic is self-contained for use without an internet connection.

## 🛠 Tech Stack

- **Flutter**: Native mobile/desktop shell and lifecycle management.
- **WebView**: Embedded high-performance 3D rendering engine.
- **Vanilla CSS 3D**: Lightweight, dependency-free 3D cube visualization.
- **JavaScript**: Core cubing logic and state management.

## 📱 Getting Started

### Prerequisites

- Flutter SDK (3.41+)
- Android SDK / iOS Xcode for mobile deployment
- ADB (for Android debugging)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/LinkZelad/roux_cube_trainer.git
   cd roux_cube_trainer
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run on a connected device:
   ```bash
   flutter run
   ```

## 📖 Usage

- **Switch Categories**: Use the sidebar tabs to filter between FB, SB, CMLL, and LSE.
- **Inspect**: Drag the cube in the central zone to rotate.
- **Learn**: Press "Play" (▶) to watch the algorithm animation.
- **Verify**: Type your solution in the input box and click "Check" to compare it with the reference.

## 🤝 Contributing

Contributions are welcome! Whether it's adding more cases, improving 3D performance, or refining algorithms, feel free to open a PR.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
