# ✈️ Skiee Flight App

A modern, scalable **Flutter flight booking application** built using **Clean Architecture** and the **MVVM pattern**, featuring a complete in-app authentication and booking experience.

---

##  Overview

**Skiee** is a fully functional flight booking app designed to deliver a smooth and intuitive user experience. It allows users to:

* 🔐 Create and manage accounts
* ✈️ Browse and explore flights
* ❤️ Save favorite flights
* 📅 Book flights easily
* 🔍 Search and filter flights
* 📖 View booking history

The app emphasizes **clean structure, scalability, and maintainability** through well-defined architecture principles.

---

##  Key Features

###  Authentication

* User registration with validation
* Secure email/password login
* Password visibility toggle
* Terms & conditions enforcement
* Session persistence during runtime

###  Home Experience

* Personalized greeting
* Dynamic favorites preview
* Discover flights section
* Quick navigation via search

###  Flight Management

* Browse all available flights
* Detailed flight information:

  * Timeline (departure & arrival)
  * Aircraft & class details
  * Amenities (Wi-Fi, meals, USB, etc.)
  * Carbon emissions estimate

###  Favorites System

* Add/remove flights instantly
* Real-time UI updates
* Confirmation dialogs
* Dedicated favorites screen with count

###  Booking System

* Passenger selection (1–10)
* Live price calculation
* Booking confirmation with reference ID
* Upcoming & past bookings view
* Prevent duplicate bookings

###  Search & Filters

* Search by airline, city, or airport code
* Filter by:

  * Class (Economy / Business)
  * Price range
  * Airline
* Sorting options:

  * Price ↑ / ↓
  * Duration
* Persistent filter state

###  Profile

* User info display
* Membership tier
* Favorites shortcut
* Secure logout

###  UI/UX

* Responsive design (`flutter_screenutil`)
* Error handling with snackbars
* Consistent theming system

---

## 🏗 Architecture

The app follows a **feature-based MVVM + Clean Architecture** approach:

```
Presentation Layer  → UI (Screens & Widgets)
        ↓
Logic Layer        → Cubits (State Management)
        ↓
Domain Layer       → Entities & Repositories
        ↓
Data Layer         → Services & Models
```



##  Project Structure

```
lib/
│
├── main.dart
│
├── app/
│   └── app.dart
│
├── core/
│   │
│   ├── constants/
│   │   ├── app_icons.dart
│   │   └── app_images.dart
│   │
│   ├── data/
│   │   ├── models/             
│   │   │   ├── flight_model.dart
│   │   │   ├── user_model.dart
│   │   │   ├── mock_flight_data.dart
│   │   │   └── enum/
│   │   │       └── flight_class.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── auth/
│   │   │   └── flight/
│   │   │
│   │   └── services/
│   │       ├── auth/
│   │       ├── fav/
│   │       └── flight/
│   │
│   ├── providers/
│   │   └── app_providers.dart
│   │
│   ├── routing/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_text_style.dart
│   │
│   │
│   └── widgets/
│       ├── custom_app_bar.dart
│       ├── custom_bottom_nav_bar.dart
│       ├── discover_flight_card.dart
│       └── primary_button.dart
│
└── features/
    │
    ├── authentication/
    │   ├── logic/
    │   │   └── cubit/
    │   │       ├── auth_cubit.dart
    │   │       └── auth_state.dart
    │   │
    │   └── view/
    │       ├── screens/
    │       │   ├── sign_in_screen.dart
    │       │   └── sign_up_screen.dart
    │       └── widgets/
    │           ├── input_text_field.dart
    │           ├── or_divider.dart
    │           ├── social_button.dart
    │           └── terms_dialog.dart
    │
    ├── booking/
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── booking_model.dart
    │   │   │   └── enum/
    │   │   │       └── booking_status.dart
    │   │   ├── repositories/
    │   │   └── services/
    │   │
    │   ├── logic/
    │   │   └── cubit/
    │   │       ├── booking_cubit.dart
    │   │       └── booking_state.dart
    │   │
    │   └── view/
    │       ├── screens/
    │       │   ├── bookings_screen.dart
    │       │   └── booking_screen.dart
    │       └── widgets/
    │           └── build_flight_list.dart
    │
    ├── favorites/
    │   ├── logic/
    │   │   └── cubit/
    │   │       ├── favorites_cubit.dart
    │   │       └── favorites_state.dart
    │   │
    │   └── view/
    │       ├── screens/
    │       │   └── favorite_screen.dart
    │       └── widgets/
    │           ├── favorite_dialog.dart
    │           └── favorite_flight_card.dart
    │
    ├── flight_details/
    │   └── presentation/
    │       ├── screens/
    │       │   └── flight_details_screen.dart
    │       └── widgets/
    │           ├── experience_chip.dart
    │           ├── extension_tile.dart
    │           └── flight_timeline.dart
    │
    ├── home/
    │   └── view/
    │       ├── screens/
    │       │   └── home_screen.dart
    │       └── widgets/
    │
    ├── profile/
    │   └── view/
    │       ├── screens/
    │       │   └── profile_screen.dart
    │       └── widgets/
    │           ├── account_card.dart
    │           ├── profile_header.dart
    │           └── profile_tile.dart
    │
    └── search/
        ├── logic/
        │   └── cubit/
        │       ├── search_cubit.dart
        │       └── search_state.dart
        │
        └── view/
            ├── screens/
            │   └── search_screen.dart
            └── widgets/
                ├── custom_search_bar.dart
                └── filter_bottom_sheet.dart
```

---

##  Tech Stack

| Technology         | Purpose                |
| ------------------ | ---------------------- |
| Flutter            | UI Framework           |
| Dart               | Programming Language   |
| flutter_bloc       | State Management       |
| equatable          | State comparison       |
| dartz              | Functional programming |
| flutter_screenutil | Responsive design      |
| flutter_svg        | SVG rendering          |

---

##  Getting Started

### Prerequisites

* Flutter
* Dart

### Installation

```bash
git clone https://github.com/SaraYasser28/flights_app.git
cd flights_app
flutter pub get
flutter run
```

---

##  Screens Overview

###  Authentication

* Sign In
* Sign Up

###  Home

* Favorites preview
* Discover flights

###  Flight Details

* Timeline, amenities, pricing
* Booking entry point

###  Search

* Real-time filtering
* Advanced sorting

###  Favorites

* Manage saved flights

###  Bookings

* Upcoming & past trips

###  Profile

* User info & settings

---

##  Authentication System

* In-memory user storage
* Full validation pipeline
* Auto-login after registration
* Session maintained until logout

---

##  Favorites System

* Stored in memory run-time
* Instant UI synchronization across screens

---

##  Booking System

* Dynamic pricing
* Booking reference generation
* Duplicate booking prevention
* Organized booking history

---

##  Search & Filtering

* Multi-field search support
* Advanced filtering & sorting
* State persistence in Cubit

---


##  Future Improvements

*  Persistent storage (SQLite / Hive) or firebase integration
*  API integration
*  Payment system
*  Push notifications
*  Dark mode

---

##  Author

**Sara Yasser Ahmed**

* GitHub: [https://github.com/SaraYasser28](https://github.com/SaraYasser28)