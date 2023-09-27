//
//  CategoryDashboardView.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class CategoryDashboardViewController: UIViewController, CategoryDashboardViewProtocol {

  // MARK: - VIPER Variables
  var presenter: CategoryDashboardPresenterProtocol?

  // MARK: - Variables
  let mainStackView: UIStackView = UIStackView()
  let welcomeView = UIView()
  let loaderView = UIActivityIndicatorView()
  var mainCollectionView: UICollectionView?

  let categoryCellId = "CategoryCell"
  let uberFontString: String = "UberMoveMedium"

  // MARK: - UIViewController Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.viewDidLoad()
    generateUI()
    showLoader()
    setupColorNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }

  // MARK: - Presenter -> View Functions
  func loadCollectionView() {
    self.generateCollectionView()
  }

  func reloadCollectionView() {
    loaderView.isHidden = true
    mainCollectionView?.reloadData()
  }

  // MARK: - UI Functions
  func setupColorNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.white // your colour here

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

  // UI Functions
  func generateUI() {
    // Main Stack View
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.axis = .vertical
    welcomeView.backgroundColor = .white
    view.addSubview(mainStackView)

    // Main Label
    let labelView = UILabel()
    labelView.textColor = .black
    labelView.text = "Welcome!"
    welcomeView.addSubview(labelView)
    labelView.clipsToBounds = true
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.centerYAnchor.constraint(equalTo: welcomeView.centerYAnchor).isActive = true
    labelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    labelView.leadingAnchor.constraint(equalTo: welcomeView.leadingAnchor, constant: 16).isActive = true
    labelView.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor, constant: -16).isActive = true
    labelView.font = UIFont(name: uberFontString, size: 16.0) ?? UIFont.systemFont(ofSize: 26.0)

    // Loader View
    loaderView.style = .large
    loaderView.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
    loaderView.color = .black

    mainStackView.addArrangedSubview(welcomeView)
    mainStackView.addArrangedSubview(loaderView)

    addConstraints()
  }

  private func generateCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: view.frame.width / 2 - 30, height: 300)
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1

    let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    myCollectionView.backgroundColor = UIColor.white
    myCollectionView.dataSource = self
    myCollectionView.delegate = self
    myCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
    myCollectionView.showsVerticalScrollIndicator = false
    myCollectionView.backgroundColor = UIColor.white
    mainCollectionView = myCollectionView
    mainStackView.addArrangedSubview(myCollectionView)
  }

  func addConstraints() {
    mainStackView.topAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    mainStackView.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    mainStackView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    mainStackView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    welcomeView.heightAnchor.constraint(
      equalToConstant: 60).isActive = true
  }

  // Loader Functions
  func showLoader() {
    loaderView.startAnimating()
  }

  func hideLoader() {
    loaderView.isHidden = true
  }
}

// MARK: - UICollectionView Functions
extension CategoryDashboardViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.getNumberOfCategories() ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = presenter?.getCategoryCell(index: indexPath.item)
    return cell ?? UICollectionViewCell()
  }
}

extension CategoryDashboardViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let mealCategory: MealCategory = presenter?.getMealCategory(index: indexPath.item) else {
      return
    }
    let mealDashboardView = MealDashboardWireFrame.presentMealDashboardModule(mealCategory: mealCategory.strCategory)
    self.navigationController?.pushViewController(mealDashboardView, animated: true)
  }
}

extension CategoryDashboardViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2 - 1, height: 250)
  }
}
