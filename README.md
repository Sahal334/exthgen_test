# exthgen_test

A new Flutter project.

flutter vertion 3.32.1



## Getting Started
Overview:
Recreate the MindMate app UI as shown in the images. This includes:

working = firstscreen getstart button->second screen save mood button->third screen

A mood reflection wheel screen

A user profile dashboard with stats and mood graph

A welcome/onboarding screen

UI Screens to Develop:

-> 1. Daily Reflection Screen

Core Components:

Custom Mood Wheel with Emojis positioned in a circular layout.

Centered Mood Status indicator ("Mood: Good").

Two stat cards at the bottom: Intake and Mental Effect.

A Save Mood button with gradient background and emoji.

Flutter Widgets & Packages:

Stack + Positioned for emoji placement.

CustomPaint or flutter_arc_text for arc labels.

Circular Percent Indicator for the mood level circle.

syncfusion_flutter_charts for the bottom graph.

Google Fonts, AnimatedContainer, GestureDetector.

-> Profile Dashboard
Core Components:

Profile picture with mood percentage.

3 category icons: Mental Energy, Emotional Balance, Creative Flow.

Weekly Mood Graph with multi-colored bars.

AI Suggestions section with an action card (e.g., meditation task).

Flutter Widgets & Packages:

Column, Row, CircleAvatar, LinearProgressIndicator.

BarChart using syncfusion_flutter_charts for weekly mental energy.

Container + BoxDecoration for AI suggestion cards.

Gradient buttons using InkWell or ElevatedButton.styleFrom.

-> Welcome/Onboarding Screen 
Core Components:

App logo + mascot hugging a brain.

Onboarding message: “Unlock the power of your mind.”

“Get Started” and “Skip” buttons at the bottom.

Flutter Widgets & Packages:

Image.asset or SvgPicture.asset for illustrations.

RichText for mixed font styling.

PageView or IntroductionScreen package for multiple onboarding pages.

ElevatedButton with gradient for CTA.
