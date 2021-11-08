//
//  HomeViewController.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    internal let viewModel = HomeViewModel(with: ProductsService())
    private var dataSource: [Product] = []
    
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
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 80
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)

        tableView.register(UINib(nibName: ProductCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: ProductCell.identifier)
        
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
        if dataSource.isEmpty {
            self.tableView.showLoading()
        }
        viewModel.fetchProducts()
    }
}

// MARK: - ViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingProducts(products: [Product]) {
        self.dataSource = products
        self.showTableView()
    }
    
    func onFailureFetchingProducts(error: Error) {
        self.tableView.backgroundView = self.getEmptyView()
    }
}

// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier,
                                                       for: indexPath) as? ProductCell else { return UITableViewCell() }
        cell.config(with: product)
        return cell
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
        labelDescription.text = "Looks like that you don't have internet. \nPlease check it out and pull to refresh."
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
