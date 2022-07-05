# ConvexHull Algorithm Map Project

<img src="https://i.ibb.co/TPhTNc2/algo.png" alt="algo">

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
12. Add SharedPreferences so user can be stored and remembered.

## Errors Encountered

    - Post Request receiving error 500 this was due to not hooking TextEditingControllers to the textfield.
    - Google Map was not centered to Invercargill this was due to NESW so coord needed to be negative.
    - All User markers were all the same color this was due to random accessing wrong max index.
    - Convex hull was not in the correct order this was due to the SignedArea formuala being incorrect.
    - ConvexHull was solid color this was due to not using opacity.
    - SharedPreferences was not pulling correct data this was due to incorrect error checking of the variables.
    - Connection checker was only checking the home screen and not any of the other screens this was due to only
    having access to one of the methods.

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
| 8       | Save Credentials of user        | Fail   |
| 9       | Save Credentials of user        | Fail   |
| 10      | Save Credentials of user        | Pass   |

### What Went Wrong

- Test case 1: Running the get request method via the application resulted in status code 200 which passed the test case.
- Test case 2: Post Request returned error 500 which failed the test case.
- Test case 3: Post request was fixing by checking the params of the json encoded map showed that twop values were null,
  once fixed this issue the request resuted in status code 201 which passed the test case.
- Test case 4: Display all User markers successfully were added to the google map which passed the test case.
- Test case 5: Convex Hull around user markers failed due to the Signed Area not correct which failed the test case.
- Test case 6: Convex hull around all user markers worked after fixing signed area which passed the test case.
- Test case 7: Display Total Area of user hull shows incorrect number which failed the test case.
- Test case 8: Save Credentials of user to sharedpreferences failed the test case.
- Test case 9: Fixed the save credentials by looking at docs on pub dev and fixed some bugs which didnt fix the problem
  which failed the test case.
- Test case 10: Save credentials of the user worked after wrong error check on variable which passed the test case.

## User Manual

### Installation

This app requires [Flutter](https://flutter.dev/) v3.0+ to run.

```sh
git clone https://github.com/Riley-Howley/algorithms_mobile
cd algorithms_mobile
flutter run
```

### Note

To ensure the app runs perfectly ensure that in the app settings that the permissions are accepted

> Note: <span style="color:red">YOUR INFORMATION IS SAVED ON A PUBLIC SERVER</span> and will be viewed by many people.

### How to use

Once the application has launch add your name to the textfield or click add user to save your details
for later. Then click the world to (Explore!).
You will then be prompted with two text fields fill them in if you want to add a new location.
If you want to edit your credentials click edit user.
Click view to see four options of userid or add your own. When click either one or all of them
click View Maps and you will then see the google map with the markers and the convex hull.
Only markers will displayed on the map if the userid exists and polygon (Hull) will not be drawn
unless the userid points are >= 3;

# Broken Code

Due to the Convex hull points being coords this made it very difficult to calculate the total area.
In the future I would like to have the abiity to show the total area of the hull on the screen to
be viewed by the users.
Here is a link to the stackoverflow post that I was using to try and solve this problem.
[Stack Overflow](https://stackoverflow.com/questions/2861272/polygon-area-calculation-using-latitude-and-longitude-generated-from-cartesian-s)

# Conclusion

Feel Free to pull the code and look around and use it for your own benefit.
If you have any idea how to solve the total area issue submit a pull request.
Kia Kaha Algo
