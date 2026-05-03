# Onboarding Flow example
A modern iOS application implementing a multi-step onboarding flow with HealthKit integration and calorie budget calculation.

## 1. Requirements Overview
Based on the provided technical specification, the app implements:

Step-by-step Onboarding: Gender selection, Health App data import, Weight entry, and Date of Birth validation.

HealthKit Integration: Automated fetching of Weight, Height, and Date of Birth.

Validation: Strict rule for users to be at least 13 years old.

Calorie Budgeting: Real-time calculation using the EER (Estimated Energy Requirement) formula.

Localization Support: Automatic unit switching (kg/kJ vs. lbs/kcal) based on regional settings.

## 2. Technical Observations & Specification Deviations
Metric System Logic (en-US)
During development, a potential contradiction was identified in the requirements:

Requirement: "The app should set [Metric System] by default to ON for en-us locale and OFF otherwise."

Observation: Typically, the en-US locale (United States) uses the Imperial system (lbs/kcal), while the rest of the world uses Metric (kg/kJ).

Implementation: To demonstrate strict adherence to the provided technical documentation, the app enables Metric by default for en-US. However, the architecture is flexible enough to toggle this logic easily if the requirement is clarified as a typo.

## 3. Architecture & Design Decisions
Coordinator Pattern
The app utilizes the Coordinator Pattern (OnboardingCoordinator) managing a UINavigationController.

Why: This ensures a clean separation between business logic and navigation. The Coordinator owns the UserSession state and dictates the flow, keeping ViewModels lean and focused only on their respective screens.

Flexibility: While the current flow is linear, the Coordinator easily allows for back-navigation and data persistence between steps.

Note on Scalability: For this specific linear flow, UINavigationController is the most native and efficient choice. However, if the onboarding were to become non-linear (with conditional branching or complex screen jumps), I would consider a State-Driven approach using custom transitions or a ZStack switch in SwiftUI to handle more complex view hierarchy swaps.

MVVM + Clean Services
Each screen is built with SwiftUI and backed by an ObservableObject ViewModel. Heavy logic is extracted into specialized services:

HealthKitService: Encapsulates GCD-based interaction with Apple Health.

CalorieCalculatorService: A pure domain service for mathematical calculations, isolated from the UI for easy Unit Testing.


## 4. Testing
The project includes Unit Tests for the core business logic:

Calorie Calculation: Validating EER formulas for both genders with high precision.
