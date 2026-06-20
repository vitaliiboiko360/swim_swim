# swim_swim

**State management choice ?**

Bloc (https://bloclibrary.dev/ flutter package https://pub.dev/packages/flutter_bloc)  
it is standard for state management in Flutter application.

**Brief description of project structure ?**  
not every class resides in a separate file, but particular attention was paid to put all related stuff into their own file/folder.

**What would do differently with more time ?**  
Anything that improves code maintainabilty.

**Explain key decisions — why you chose this approach, not just what it does**

- For evalution and convenience purposes, this solution was developed for Flutter Web, so it's not needed to install mobile emulator to run it locally. But the code could be used for mobile application platforms as well.
- For seconds text input, delay applied to correct usability.
- Users have its own model. When fetching from API it's used to hold the data.

**Task 1 — Pace Selector**  
Requirements  
**Pace input (MIN : SEC)**

✅ Two large numeric displays for minutes and seconds  
✅ Up/down arrows to increment or decrement each value  
✅ Tap to edit — allow direct numeric input  
✅ Validate: seconds must be 0–59

**Slider**

✅ A horizontal slider below the timer  
✅ Visible tick marks or labels at key points

> Labels corresponds to time ranges in **Swimmer level**

✅ Moving the slider updates the MIN:SEC display in real time  
✅ Editing MIN:SEC also moves the slider

**Swimmer level**

✅Display the current level below the timer

> Levels are:
> Beginner, Middle, Advanced, Elite

✅Level updates dynamically as the value changes  
✅Define the time ranges yourself and document them in the README

> Ranges are:  
> 1:00, 1:30, 2:00

**Continue button**

✅ On tap, convert the selected time to total seconds (MIN \* 60 + SEC)

> value already present and doesn't require separate conversion

✅ Send a POST request to https://jsonplaceholder.typicode.com/posts with body:  
`{ "pace_seconds": 137 }`  
✅ Show a loading indicator while the request is in progress  
✅ Handle network errors gracefully (show an error message)

⭕ Use a debounce of ~500ms if you trigger requests on slider change

> not implemented

**Task 2 — User List**  
**User List screen**  
✅ Fetch and display users from the API  
✅ Show at minimum: Name, Email, Phone number  
✅ Add search or filter by name  
✅ Allow users to refresh the data

**User Detail screen**  
✅ Tapping a user navigates to a detail screen  
✅ Display additional information about the selected user
