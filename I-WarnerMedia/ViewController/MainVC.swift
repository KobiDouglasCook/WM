//
//  ViewController.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/28/21.
//

import UIKit

class MainVC: UIViewController {
   
    //MARK: UI Components
    let tableView = UITableView()
    
    //MARK: Properties
    let viewModel = ViewModel()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
    
    
    
    //MARK: Helper Functions
    private func setup() {
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.setupToFill(superView: view)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.identifier)
        
        viewModel.get()
        viewModel.delegate = self
    }
    

}

//MARK: TableView
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier, for: indexPath) as! ProductTableCell
        let product = viewModel.getProduct(for: indexPath)
        cell.product = product
        return cell
    }
    
}


extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.setCurrentProduct(for: indexPath)
        let detailVC = DetailVC()
        detailVC.delegate = self
        detailVC.viewModel = viewModel
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
        print("tapped table cell: \(indexPath.row)")
    }
}

//MARK: ViewModelDelegate
extension MainVC: ViewModelDelegate {
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: DetailDelegate
extension MainVC: DetailDelegate {
    
    func favoriteToggled() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
