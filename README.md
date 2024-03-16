# Simple Flutter App for Testing Firebase Cloud Messaging (FCM) with HTTP API V1

This is a simple Flutter application created for testing and gaining knowledge about various packages and Firebase solutions, particularly Firebase Cloud Messaging (FCM) using the Firebase HTTP API V1. The app also utilizes other packages for local notifications, data persistence, and map integration.

## Features

- Integration with Firebase Cloud Messaging (FCM) using HTTP API V1 for push notifications.
- Implementation of local notifications for both automatic and manual deletion using the `flutter_local_notifications` package.
- Utilization of Hive for local data persistence.
- Integration of Map Launcher to display the location of doctors using Google Maps.
- Usage of URL Launcher for contacting doctors through various communication channels.

## Packages Used

- **Firebase Cloud Messaging (FCM) HTTP API V1**: Used for sending and receiving push notifications.
- **flutter_local_notifications**: Implemented for displaying local notifications.
- **hive**: Utilized for local data storage and retrieval.
- **map_launcher**: Integrated to show the location of doctors using Google Maps.
- **url_launcher**: Used to launch communication channels such as phone, email, etc.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Ensure you have Flutter installed. If not, follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install).
3. Navigate to the project directory and run `flutter pub get` to install dependencies.
4. Configure Firebase for your project and obtain the necessary credentials.
5. Replace the placeholder Firebase configuration in `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` with your actual Firebase credentials.
6. Run the app on an emulator or physical device using `flutter run`.

## Usage

Once the app is running, you can explore the features listed above:

- Receive push notifications from the Firebase console or by sending requests to the FCM HTTP API V1. // i just test the functions and they work just make the connections between the front-end and the logic
- View a list of doctors and their details.
- Click on a doctor to view their location on Google Maps.
- Contact doctors via phone, email, or other communication channels.
- have a simple todo list 

## Contribution

Contributions are welcome! If you find any bugs or have suggestions for improvement, please feel free to open an issue or submit a pull request.
