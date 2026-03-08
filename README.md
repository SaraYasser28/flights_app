# ✈️ Skiee Flight App UI

A modern **Flutter flight booking UI application** built using **clean architecture principles** and **reusable components**.

This project focuses on **UI design, responsive layouts, and scalable Flutter project structure**.

---

#  Table of Contents

| Section                                 | Description                        |
| --------------------------------------- | ---------------------------------- |
| [Overview](#overview)                   | General description of the project |
| [Features](#features)                   | Main UI features implemented       |
| [Project Structure](#project-structure) | Folder architecture                |
| [Tech Stack](#tech-stack)               | Technologies used                  |
| [Dependencies](#dependencies)           | Flutter packages used              |
| [Getting Started](#getting-started)     | How to run the project             |
| [Screens Included](#screens-included)   | Implemented app screens            |
| [UI Design](#ui-design)                 | Design goals and UI approach       |
| [Notes](#notes)                         | Additional project information     |
| [Author](#author)                       | Project author                     |

---

# Overview

**Skiee** is a **flight booking interface prototype** that demonstrates how a modern travel application might look and behave.

It includes multiple UI screens such as:

* Authentication
* Home
* Flight Details
* Bookings
* Profile

This project is currently **UI-only** and does not include backend/firebase/database integration in this phase.

---

# Features

*  Authentication Screens

  * Sign In
  * Sign Up

*  Home Screen

  * Favorite Flights
  * Discover Flights
  * Search Bar

*  Flight Details Screen

  * Flight Timeline
  * Flight Experience
  * Flight Extensions

*  Bookings Screen

*  Profile Screen

*  Responsive UI using **flutter_screenutil**

*  Custom Theme System

*  Reusable Widgets

*  Feature-based modular project structure

---

# Project Structure

```
lib/
│
├── core/
│   ├── constants/
│   │   ├── app_icons.dart
│   │   └── app_images.dart
│   │
│   ├── routing/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_text_style.dart
│   │
│   └── widgets/
│       ├── custom_app_bar.dart
│       ├── custom_bottom_nav_bar.dart
│       └── primary_button.dart
│
├── features/
│   ├── authentication/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── sign_in_screen.dart
│   │       │   └── sign_up_screen.dart
│   │       │
│   │       └── widgets/
│   │           ├── input_text_field.dart
│   │           ├── or_divider.dart
|   |           ├── terms_dialog.dart
│   │           └── social_button.dart
│   │
│   ├── booking/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── bookings_screen.dart
│   │       │
│   │       └── widgets/
│   │           └── build_flight_list.dart
│   │
│   ├── flight_details/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── flight_details_screen.dart
│   │       │
│   │       └── widgets/
│   │           ├── experience_chip.dart
│   │           ├── extension_tile.dart
│   │           └── flight_timeline.dart
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       │
│   │       └── widgets/
│   │           ├── discover_flight_card.dart
│   │           └── favorite_flight_card.dart
│   │
│   ├── profile/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── profile_screen.dart
│   │       │
│   │       └── widgets/
│   │           ├── account_card.dart
│   │           ├── profile_header.dart
│   │           └── profile_tile.dart
│   │
│   └── search/
│       └── presentation/
│           └── widgets/
│               └── custom_search_bar.dart
│
└── main.dart
```

This structure follows a **feature-based architecture**, making the project easier to scale and maintain.

---

# Tech Stack

| Technology | Usage                |
| ---------- | -------------------- |
| Flutter    | UI Framework         |
| Dart       | Programming Language |

---

# Dependencies

Main packages used in the project:

```yaml
flutter_screenutil: ^5.9.3
flutter_svg: ^2.0.10
```

Install dependencies:

```bash
flutter pub get
```

---

# Getting Started

### 1️- Clone the repository

```bash
git clone https://github.com/SaraYasser28/flights_app.git
```

### 2️- Navigate to the project directory

```bash
cd flights_app
```

### 3️- Install dependencies

```bash
flutter pub get
```

### 4️- Run the application

```bash
flutter run
```

---

# Screens Included

| Screen         | Status      |
| -------------- | ----------- |
| Sign In        | Implemented |
| Sign Up        | Implemented |
| Home           | Implemented |
| Flight Details | Implemented |
| Bookings       | Implemented |
| Profile        | Implemented |

### Planned Screens

* *See More* button Flights screen
* Favorite Flights Screen

---

# UI Design

The UI focuses on:

* Clean and minimal layout
* Reusable UI components
* Responsive spacing
* Consistent typography
* Modern travel application aesthetics

---

# Notes

* The current project is **UI only**.
* No backend or API integration is currently implemented.
* Flight information is **mock data used for UI demonstration**.
* Backend integration may be implemented in future phases.

---

# Author

Developed by **Sara Yasser Ahmed**.

---