# ConvexHull Algorithm Map Project

https://i.ibb.co/TPhTNc2/algo.png

What does the convexhull algorithm do?

> Computation. In computational geometry, a number of algorithms are known for computing the convex hull for a finite set of points and for other geometric objects. Computing the convex hull means constructing an unambiguous, efficient representation of the required convex shape.

## Planning

1. Create Mobile App with Flutter
2. Add Connectivity Checker to the main method
3. Create an add UserLocation with two textfields
   - UserId
   - Description
4. Add the ability for the user to fetch location using a button
5. Create a file for Http Requests using HttpClient to Kens Server (Get and Post)
6. Add dialogs to display to the user the status of their request
   - 200 = Successful Request
   - 201 = Successful Post
   - 500 = Something Terrible went wrong
     Due to the scope of the project I will add two dialogs Success or Error
7. Make a decision to use Flutter or Windows Forms for google maps
   - Decided to use Flutter
8. Add dependencies for Flutter Google Maps
9. Center the map in the middle of invercargill
10. Add all userid Locations as a marker to the map
11. Perform Convex Hull algorithm around the users points

## Error Encountered

    - Post Request receiving error 500 this was due to not hooking TextEditingControllers to the textfield.
    - Google Map was not centered to Invercargill this was due to NESW so coord needed to be negative.
    - All User markers were all the same color this was due to random accessing wrong max index.
    - Convex hull was not in the correct order this was due to the SignedArea formuala being incorrect.
    - ConvexHull was solid color this was due to not using opacity.

## Testing

| Test ID | Test Case                       | Result |
| ------- | ------------------------------- | ------ |
| 1       | Get Request to the server       | Pass   |
| 2       | Post Request to the server      | Fail   |
| 3       | Post Request to the server      | Pass   |
| 4       | Display User Markers            | Pass   |
| 5       | Convex Hull around users Points | Fail   |
| 6       | Convex Hull around users Points | Pass   |
| 7       | Display total area of hull      | Fail   |

## User Manual

### Instalation

This app requires [Flutter](https://flutter.dev/) v3.0+ to run.

```sh
git clone https://github.com/Riley-Howley/algorithms_mobile
cd algorithms_mobile
flutter run
```

### Note

To ensure the app runs perfectly ensure that in the app settings that the permissions are accepted

> Note: `YOUR INFORMATION IS SAVED ON A PUBLIC SERVER` and will be viewed by many people.

### How to use
