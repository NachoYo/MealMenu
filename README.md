# MealMenu
MealMenu DemoApp for UIKit and SwiftUI Learning

## Techincal Info
- iOS Native Application written in Swift
- Application done in two Versions: UIKit and SwiftUI
- Minimum iOS version: iOS 15.0
- Compiled and compatible with Xcode 15.0 and Xcode 14.3

## App Functions
- Selection between UIKit and SwiftUI Version
- Dashboard Screen for Meal Categories
- Dashboard Screen for Meal Selection
- Detail Screen for Ingredients and Instructions for a meal
- Filter of null or empty values from the APIs responses
- Alphabetic Sorting of the categories and meals

## Swift Technical Knowldge Checks
- Programmatic UI
- Codable for JSON serialization
- Dedicated Networking layer
- Good project structure
- UIImageView extension to download and cache the image data
- Unit Testing with a class based approach (Only for SwiftUI classes)
- Knowledge of Combine
- Knowledge of Swift Concurrency
- Knowledge of SwiftUI

## API Endpoints used
- https://www.themealdb.com/api/json/v1/1/categories.php for fetching the list of meals categories
- https://themealdb.com/api/json/v1/1/filter.php?c=CATEGORY for fetching the list of meals of a category
- https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID for fetching the details of a meal

## Technical Debts
- Thread Saftey using actors or locks
- Unit Tests for all the UIKit Version of the APP and more complete Unit Tests for the SwiftUI version.
- UIImage Cache usage for the UIKit Version of the APP.
- Error handling and retry option in case that the APIs fail.
  
# App Video
https://github.com/NachoYo/MealMenu/assets/49642496/d5f2b649-a0dd-4796-9861-1c1acc043bd2
