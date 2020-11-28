# FastAid

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


DATA='{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "/topics/all"}'

curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=AAAAD1dC3Ek:APA91bF1GuYO4MLNt4oNECQNIY9s9Jj48JiIrfCmCHTZv41vm4lWm5jVF3Hwwk7wsbPQlnBkYgJhOW7qcA40fQVMAe_4A1Akmz2duRHYIBkwj5DIAlMn1dNX0qzhj9KtjvIOEvlq7RPB"