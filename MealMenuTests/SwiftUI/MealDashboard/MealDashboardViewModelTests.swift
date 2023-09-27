//
//  MealDashboardViewModelTests.swift
//  MealMenuTests
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import XCTest
import Foundation
@testable import MealMenu

final class MealDashboardViewModelTests: XCTestCase {

  // MARK: - Properties
  var sut: MealDashboardViewModel!

  // MARK: - Initialization
  override func setUp() {
    super.setUp()
    sut = MealDashboardViewModel(mealCategory: "Dessert")
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testFetchMealDetail() {
    // Given
    let expectation: XCTestExpectation = expectation(description: "Data fetched and decoded successfully with at least 1 item in the list")
    // When
    sut.fetchMeals()
    var mealListCount: Int = 0
    // Then
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      if self.sut.mealList.count > 0 {
        mealListCount = self.sut.mealList.count
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 5)
    XCTAssertGreaterThan(mealListCount, 0)
  }
}
