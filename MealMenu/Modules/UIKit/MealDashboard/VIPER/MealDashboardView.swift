//
//  CategoryDashboardView.swift
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import UIKit

class MealDashboardViewController: UIViewController, MealDashboardViewProtocol {

  // MARK: - VIPER Variables
  var presenter: MealDashboardPresenterProtocol?

  // MARK: - Variables
  var mainStackView: UIStackView = UIStackView()
  let welcomeView = UIView()
  var mainCollectionView: UICollectionView?
  let loaderView = UIActivityIndicatorView()
  let mealCellId = "MealCell"

  let uberFontString: String = "UberMoveMedium"

  // MARK: - UIViewController Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = presenter?.getMealCategoryName() ?? "Meal Category"
    self.presenter?.viewDidLoad()
    self.generateUI()
    self.showLoader()
    self.navigationController?.isNavigationBarHidden = false
  }

  // MARK: - Presenter -> View Functions
  func loadCollectionView() {
    self.generateCollectionView()
    self.hideLoader()
  }
  func reloadCollectionView() {
    mainCollectionView?.reloadData()
  }

  // MARK: - UI Functions
  private func generateUI() {
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.axis = .vertical
    welcomeView.backgroundColor = .white
    mainStackView.addArrangedSubview(welcomeView)

    let labelView = UILabel()
    labelView.textColor = .black
    labelView.text = "Choose your meal"
    welcomeView.addSubview(labelView)
    labelView.clipsToBounds = true
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.centerYAnchor.constraint(equalTo: welcomeView.centerYAnchor).isActive = true
    labelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    labelView.leadingAnchor.constraint(equalTo: welcomeView.leadingAnchor, constant: 16).isActive = true
    labelView.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor, constant: -16).isActive = true
    labelView.font = UIFont(name: uberFontString, size: 16.0) ?? UIFont.systemFont(ofSize: 26.0)

    view.addSubview(mainStackView)

    // Loader View
    loaderView.style = .large
    loaderView.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
    loaderView.color = .black
    mainStackView.addArrangedSubview(loaderView)
    
    addConstraints()
  }

  private func generateCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    myCollectionView.backgroundColor = UIColor.white
    myCollectionView.dataSource = self
    myCollectionView.delegate = self
    myCollectionView.register(MealCell.self, forCellWithReuseIdentifier: mealCellId)
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
extension MealDashboardViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter?.getNumberOfCategories() ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = presenter?.getMealCell(index: indexPath.item)
    return cell ?? UICollectionViewCell()
  }
}

extension MealDashboardViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let mealItem: MealItem = presenter?.getMealItem(index: indexPath.item) else {
      return
    }
    let mealImage: UIImage? = presenter?.getMealCategoryImage(idCategory: mealItem.idMeal)
    let mealDashboardView = MealDetailWireFrame.presentMealDetailModule(meal: mealItem, image: mealImage)
    self.navigationController?.pushViewController(mealDashboardView, animated: true)
  }
}

extension MealDashboardViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2 - 1, height: 250)
  }
}
