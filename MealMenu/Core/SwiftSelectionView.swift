//
//  SwiftSelectionView.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 25/09/23.
//

import UIKit

class SwiftSelectionView: UIViewController {

  // MARK: - UI Constants
  let uberFontString: String = "UberMoveMedium"

  // MARK: - UIViewController Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  // MARK: - UI Functions
  func setupUI() {
    view.backgroundColor = .white
    let UIKitButton = UIButton()
    UIKitButton.setTitle("UIKit App Version", for: .normal)
    UIKitButton.setTitleColor(.black, for: .normal)
    UIKitButton.titleLabel?.font = UIFont(name: uberFontString, size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
    UIKitButton.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
    UIKitButton.addTarget(self, action: #selector(presentUIKitApp), for: .touchUpInside)

    let swiftUIButton = UIButton()
    swiftUIButton.setTitle("SwiftUI App Version", for: .normal)
    swiftUIButton.setTitleColor(.black, for: .normal)
    swiftUIButton.titleLabel?.font = UIFont(name: uberFontString, size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
    swiftUIButton.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
    swiftUIButton.addTarget(self, action: #selector(presentSwiftUIApp), for: .touchUpInside)

    let mainStackView: UIStackView = UIStackView()
    mainStackView.addArrangedSubview(UIKitButton)
    mainStackView.addArrangedSubview(swiftUIButton)
    view.addSubview(mainStackView)
    mainStackView.distribution = .fillEqually
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.axis = .vertical
    mainStackView.spacing = 16.0
    mainStackView.topAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    mainStackView.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    mainStackView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    mainStackView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
  }

  // MARK: - Navigation Functions
  @objc func presentUIKitApp() {
    let categoryDashboardView = CategoryDashboardWireFrame.presentCategoryDashboardModule()
    let mainUINavigationController: UINavigationController = UINavigationController(rootViewController: categoryDashboardView)
    self.present(mainUINavigationController, animated: true)
  }
  
  @objc func presentSwiftUIApp() {
    let categoryDashboardView = SwiftUICategoryDashboardWireFrame.presentCategoryDashboardModule()
    self.present(categoryDashboardView, animated: true)
  }
}
