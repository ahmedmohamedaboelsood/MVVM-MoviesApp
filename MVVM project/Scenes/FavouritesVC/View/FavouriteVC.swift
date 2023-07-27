//
//  FavouriteVC.swift
//  MVVM project
//
//  Created by 2B on 26/07/2023.
//

import UIKit 

class FavouriteVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var emptyFavLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favouraitsTableView: UITableView!
    //MARK: - Variables
    var viewModel = FavoraitsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
        viewModel.fetchData()
        checkEmptyList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.removeDuplication()
    }
    
    func setupUI(){
        
        favouraitsTableView.delegate = self
        favouraitsTableView.dataSource = self
        regesterTableViewCell()
    }
    
    func regesterTableViewCell(){
        favouraitsTableView.register(UINib(nibName:MainTableViewCell.ID, bundle: nil), forCellReuseIdentifier: MainTableViewCell.ID)
    }
    
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else {return}
            guard let isLoading = isLoading else {return}
            if isLoading{
                activityIndicator.startAnimating()
            }else{
                activityIndicator.stopAnimating()
                favouraitsTableView.reloadData()
            }
        }
    }
    
    func checkEmptyList(){
        if viewModel.filmsArray.isEmpty{
            emptyFavLbl.isHidden = false
        }else{
            emptyFavLbl.isHidden = true
        }
    }
}

extension FavouriteVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfsections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.ID , for: indexPath) as! MainTableViewCell
        let film = viewModel.filmsArray[indexPath.row]
        cell.setupCellDataForCoreData(data: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.viewModel.deleteFromCoreData(indexPath: indexPath)
            tableView.endUpdates()
            self.checkEmptyList()
            completionHandler(true)
        }
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
