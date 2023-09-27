//
//  MealDetailViewModelTests.swift
//  MealMenuTests
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import XCTest
import Foundation
@testable import MealMenu

final class MealDetailViewModelTests: XCTestCase {

  // MARK: - Properties
  var sut: MealDetailViewModel!

  // MARK: - Initialization
  override func setUp() {
    super.setUp()
    let mealItemDictionary: [String: Any] = [
      "strMeal" : "Apam balik",
      "strMealThumb" : "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
      "idMeal" : "53049"
    ]
    let mealItem: MealItem? = try? MealItem(mealItemDictionary)
    sut = MealDetailViewModel(mealItem: mealItem!)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testFetchMealDetail() {
    // Given
    let expectation: XCTestExpectation = expectation(description: "Data fetched and decoded successfully")
    // When
    sut.fetchMealDetail()
    var mealDetail: MealDetail? = nil
    // Then
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      if let sutData: MealDetail = self.sut.mealDetail {
        mealDetail = sutData
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 5)
    XCTAssertNotNil(mealDetail, "Data should not be nil")
  }

  func testProcessMealDetail() {
    // When
    let mealDetailDictionary: [String: Any] = [
      "strIngredient1" : "Ingredient 1",
      "strMeasure1" : "Measure 1"
    ]

    let mealDetail: MealDetail? = try? MealDetail(mealDetailDictionary)
    sut.processMealDetail(mealDetail: mealDetail!)

    // Then
    let processedSuccessfully: Bool = sut.mealIngredients.count == 1 && sut.showGrid == true

    XCTAssertTrue(processedSuccessfully)
  }
}
