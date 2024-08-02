# Fetch-iOS-Coding-Challenge

Please write a native iOS app that allows users to browse recipes using the following API:
https://themealdb.com/api.php
There are 2 endpoints that your app should utilize:
https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the Dessert category.
https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID for fetching the meal details by its ID.

* I used SwiftUI with MVVM architchure
  
The user should be shown the list of meals in the Dessert category, sorted alphabetically. (COMPLETED)

* I added an extra feature to the meals list (the ability to cache the image)
* I noticed the images were reloading if I scrolled too far and came back so I decided to cache them so they only have to load one time

When the user selects a meal, they should be taken to a detail view that includes:
* Meal name (COMPLETED)
* Instructions (COMPLETED)
* Ingredients/measurements (COMPLETED)

* I also added a few extra deatils to the Meal Selection View page including: meal category, meal area of origin, and the meal thumbnail image.


Please read the following guidelines carefully before starting the coding challenge:
* Asynchronous code must be written using Swift Concurrency (async/await). (COMPLETED)
* Be sure to filter out any null or empty values from the API before displaying them. (COMPLETED)
* UI/UX design is not what you’re being evaluated on, but the app should be user friendly and should take basic app design principles into account. (COMPLETED)
  * I also added my own simple UI style and background gradinet color.
* Your project should compile using the latest version of Xcode. (COMPLETED)
