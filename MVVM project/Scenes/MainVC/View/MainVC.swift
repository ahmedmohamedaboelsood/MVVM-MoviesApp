//
//  MainVC.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import UIKit
import RealmSwift
import CoreData
class MainVC: UIViewController {
    
   //MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    //MARK: - Variables
    var viewModel = MainViewModel()
    var cellDataSource : [MainCellViewModel] = []
    override func viewDidLoad() { 
        super.viewDidLoad()
        viewModel.delegate = self
        configView()
        bindLoadingIndicator()
        bindRemoteData()
       // print("URL" ,Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
    //MARK: - Functions
    func configView(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crash test", style: .plain, target: self, action: #selector(self.crashButtonTapped(_:)))
        setupTableView()
    }
    
    func setupTableView(){
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        title = "Movies"
        self.regesterTableViewCell()
    }
 
    func regesterTableViewCell(){
        moviesTableView.register(UINib(nibName:MainTableViewCell.ID, bundle: nil), forCellReuseIdentifier: MainTableViewCell.ID)
    }
    
    func openMoviesDetails(movieID : Int){
        guard let movie = viewModel.retrieMovie(movieID: movieID) else {return}
        let detailsViewModel = DetailsViewModel(movie: movie)
        let detailsVC = DetailsVC(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func bindLoadingIndicator(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else{return}
            guard let isLoading = isLoading else {return}
            if isLoading {
                self.activityIndicator.startAnimating()
                print("start")
            }else{
                self.activityIndicator.stopAnimating()
                print("stop")
            }
        }
    }
    
    func bindRemoteData(){
        viewModel.cellDataSourse.bind { [weak self] movies in
            guard let self = self else{return}
            guard let movies = movies else {return}
            print(movies,"on sucsess")
            self.cellDataSource = movies
            self.moviesTableView.reloadData()
        }
    }
    
    func bindCashedData(){
        viewModel.cashedCellDataSourse.bind { [weak self] movies in
            guard let self = self else{return}
            guard let movies = movies else {return}
            print(movies,"on fail")
            cellDataSource = movies
            moviesTableView.reloadData()
        }
    }
    
    @objc func crashButtonTapped(_ sender: AnyObject) {
          let numbers = [0]
          let _ = numbers[1]
    }
}

extension MainVC : UITableViewDelegate , UITableViewDataSource , MainViewModelDelegate{
    func getcashedDataDelegate(message: String) {
        bindCashedData()
        showALert(message: message)
    }
    
    func getRemoteDataDelegate() {
        bindRemoteData()
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfsections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.ID , for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        let movie = cellDataSource[indexPath.row]
        cell.setupCellData(viewModel: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openMoviesDetails(movieID: cellDataSource[indexPath.row].id)
    }
}
