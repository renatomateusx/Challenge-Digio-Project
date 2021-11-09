//
//  HomeViewController.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    internal let viewModel = HomeViewModel(with: DigioService())
    private var dataSource: DataModel?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }
}

// MARK: - SetupUI

extension HomeViewController {
    func setupUI() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        tableView.estimatedRowHeight = 101
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)

        tableView.register(UINib(nibName: SpotlightCollectionView.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: SpotlightCollectionView.identifier)
        tableView.register(UINib(nibName: HeaderCellTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: HeaderCellTableViewCell.identifier)
        tableView.register(UINib(nibName: UIDigioTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UIDigioTableViewCell.identifier)
        tableView.register(UINib(nibName: ProductCollectionView.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: ProductCollectionView.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - SetupData

extension HomeViewController {
    func setupData() {
        viewModel.delegate = self
        self.tableView.showLoading()
        viewModel.fetchData()
    }
}

// MARK: - ViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingProducts(products: DataModel) {
        self.dataSource = products
        self.showTableView()
    }
    
    func onFailureFetchingProducts(error: Error) {
        DispatchQueue.main.async {
            self.tableView.backgroundView = self.getEmptyView()
        }
    }
}

// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sec = viewModel.sections[indexPath.section]
        switch sec {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCellTableViewCell.identifier) else { return UITableViewCell() }
            return cell
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SpotlightCollectionView.identifier, for: indexPath) as? SpotlightCollectionView else { return UITableViewCell() }
            cell.setupData(products: self.dataSource?.spotlight ?? [])
            return cell
        case .cash:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UIDigioTableViewCell.identifier, for: indexPath) as? UIDigioTableViewCell else { return UITableViewCell() }
            cell.configure(with: self.dataSource?.cash)
            return cell
        case .products:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCollectionView.identifier, for: indexPath) as? ProductCollectionView else { return UITableViewCell() }
            cell.setupData(with: self.dataSource?.products ?? [])
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sec = viewModel.sections[indexPath.section]
        switch sec {
        case .header:
            return 75
        case .spotlight:
            return 200
        case .cash:
            return 200
        case .products:
            return 200
        }
    }
}


// MARK: - Helpers

private extension HomeViewController {
    func getEmptyView() -> UIView {
        let labelDescription: UILabel = UILabel()
        labelDescription.font = .systemFont(ofSize: 20, weight: .regular)
        labelDescription.textColor = UIColor.darkGray
        labelDescription.numberOfLines = 0
        labelDescription.textAlignment = .center
        labelDescription.text = "Looks like you have a empty data."
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.sizeToFit()
        
        return labelDescription
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }
    }
}

// MARK: - ProductCollectionViewDelegate

extension HomeViewController: ProductCollectionViewDelegate {
    func didProductSelected(product: Product) {
        DispatchQueue.main.async {
            let controller = DetailViewController(with: product)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
