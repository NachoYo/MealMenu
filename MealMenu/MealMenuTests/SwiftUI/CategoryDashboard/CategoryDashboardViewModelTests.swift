//
//  CategoryDashboardViewModelTests.swift
//  MealMenuTests
//
//  Created by Luis Ignacio Vinas Petriz on 26/09/23.
//

import XCTest
import Foundation
@testable import MealMenu

final class CategoryDashboardViewModelTests: XCTestCase {

  // MARK: - Properties
  var sut: CategoryDashboardViewModel!

  // MARK: - Initialization
  override func setUp() {
    super.setUp()
    sut = CategoryDashboardViewModel()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testFetchMealDetail() {
    // Given
    let expectation: XCTestExpectation = expectation(description: "Data fetched and decoded successfully with at least 1 item in the list")
    // When
    sut.fetchCategories()
    var mealCategoriesCount: Int = 0
    // Then
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      if self.sut.mealCategories.count > 0 {
        mealCategoriesCount = self.sut.mealCategories.count
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 5)
    XCTAssertGreaterThan(mealCategoriesCount, 0)
  }
}
