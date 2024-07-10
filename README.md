# **STASHPOINTS**

## **Dependency Versions**

| **Dependency** | **Version** |
| -------------- | ----------- |
| Flutter        | 3.22.2      |
| Dart           | 3.4.3       |
| Xcode          | 15.3        |
| Android Studio | 2022.2.1    |

## **Packages**

**State Management:**

- Provider: ^6.1.2

**Networking:**

- http: ^1.2.1

**Localization:**

- intl: ^0.19.0

**UI Components:**

- flutter_svg: ^2.0.10+1
- shimmer: ^3.0.0

**Utilities:**

- flutter_dotenv: ^5.1.0
- equatable: ^2.0.5
- path_provider: ^2.1.3

## **Setting Up Development Environment**

### Prerequisites

- Install [Flutter](https://docs.flutter.dev/get-started/install) either manually or using [FVM](https://fvm.app/docs/getting_started/installation).
- Install [Android Studio](https://developer.android.com/studio/install) and [Xcode](https://apps.apple.com/us/app/xcode/id497799835).

### Getting Started

1. Clone the project from [GitHub](https://github.com/darwinmanlapat/stashpoints.git).
2. Navigate to the project directory.
3. Create `.env` file and copy these [Environment Variables](https://docs.google.com/document/d/1LqW43Y5xLz5xWtfANveMOwpz1OS49DVMmiIKJpXivjk/edit?usp=sharing)
4. Run `fvm use` to use the configured Flutter SDK version
5. Run `flutter run` to start the application. If using Visual Studio Code, select the appropriate [launch configuration](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations).

## **Folder Structure**

```bash
.
├── assets
│   ├── fonts               # Application Fonts
│   ├── ...                 # Images, SVG's, etc.
└── lib
    ├── common              # Common utilities, configurations, etc. shared across the app
    │   ├── configs         # Configuration files
    │   ├── exceptions      # Exception handling
    │   ├── interfaces      # Interfaces and services
    │   ├── services        # Utility services
    │   └── utils           # Utility functions and constants
    ├── feature
    │   ├── <feature/module>
    │   │   ├── data         # Data layer (Repositories)
    │   │   ├── domain       # Domain Layer (Entities)
    │   │   └── presentation # Presentation Layer (Screens, Widgets, Providers/Controllers)
    │   ├── <feature/module>
    │   └── ...
```
