# Kultivate - Login & Register App

A beautiful, modern Flutter application featuring innovative login and register screens with professional UI/UX design and horizontal scrolling authentication.

## Features

### 🎨 **Modern Design**
- Image carousel with auto-scrolling every 4 seconds
- Horizontal scrolling between login and register forms
- Gradient backgrounds with smooth color transitions
- Professional typography and spacing
- "Kultivate..!" branding with "Build Better Habit" tagline

### 🔐 **Authentication System**
- **Single Panel Design**: Login and register forms in one seamless experience
- **Horizontal Scrolling**: Smooth slide transitions between forms
- **Image Carousel**: Auto-scrolling through 5 PNG images with fallback gradients
- **Form Validation**: Comprehensive validation for all fields
- **Loading States**: Progress indicators during authentication

### 📱 **Login Screen**
- Email and password validation
- Password visibility toggle
- Remember me functionality
- Forgot password option
- Social login buttons (Google, Facebook, Apple)
- "Create New Account" button for horizontal navigation

### 📝 **Register Screen**
- First name and last name fields
- Email validation with regex
- Strong password requirements (8+ chars, uppercase, lowercase, number)
- Password confirmation matching
- Terms and conditions agreement
- Social registration options
- "Already Have Account? Sign In" button for navigation

### ✨ **Animations & Interactions**
- Fade-in animations on screen load
- Horizontal slide transitions between forms
- Smooth button interactions
- Loading spinners
- Success/error snackbar notifications
- Auto-scrolling image carousel

### 🎯 **User Experience**
- Form validation with helpful error messages
- Responsive design for different screen sizes
- Intuitive horizontal navigation flow
- Professional color scheme
- Accessible design elements
- Single-screen authentication experience

## Technical Features

- **Flutter 3.35.3** (stable channel)
- **Material Design 3** components
- **PageView** for horizontal scrolling between forms
- **Custom animations** with AnimationController
- **Form validation** with comprehensive error handling
- **Responsive layout** with Expanded widgets
- **Image carousel** with Timer-based auto-scrolling
- **Professional color palette** with gradient backgrounds

## Getting Started

1. **Prerequisites**
   - Flutter SDK (3.35.3 or higher)
   - Dart SDK
   - Android Studio / VS Code
   - Android device or emulator

2. **Installation**
   ```bash
   cd kultivate_app
   flutter pub get
   flutter run
   ```

3. **Running the App**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
└── screens/
    ├── auth_screen.dart      # Main authentication screen with horizontal scrolling
    ├── login_screen.dart     # Legacy login screen
    └── register_screen.dart  # Legacy registration screen
images/
├── 1.png                    # Carousel image 1
├── 2.png                    # Carousel image 2
├── 3.png                    # Carousel image 3
├── 4.png                    # Carousel image 4
└── 5.png                    # Carousel image 5
```

## Design Philosophy

The app follows modern design principles:
- **Single-Screen Experience**: Login and register in one seamless flow
- **Horizontal Navigation**: Smooth sliding between forms
- **Visual Hierarchy**: Clear branding and form structure
- **Accessibility**: High contrast colors and readable fonts
- **Consistency**: Uniform spacing and component styling
- **Professional**: Business-ready appearance
- **Innovative**: Modern carousel and horizontal scrolling

## Key Innovations

- **Horizontal Scrolling Authentication**: No separate screens, just smooth horizontal transitions
- **Image Carousel Integration**: Visual appeal with auto-scrolling images
- **Unified Branding**: "Kultivate..!" and "Build Better Habit" prominently displayed
- **Seamless UX**: Single panel design reduces cognitive load

## Future Enhancements

- Backend integration for actual authentication
- Biometric authentication support
- Dark mode theme
- Multi-language support
- Advanced form validation
- User profile management
- Image carousel customization

## License

This project is created for demonstration purposes showcasing modern Flutter UI/UX design patterns with innovative horizontal scrolling authentication.

---

**Kultivate** - *Build Better Habit* 🌱✨
