//
//  DetailsVC.swift
//  MVVM project
//
//  Created by 2B on 06/05/2023.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var movieDescriptionLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK: - Variables
    var viewModel : DetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configeView()
    }
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func configeView(){
        title = "Details"
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: viewModel.movieImage)
        movieNameLbl.text = viewModel.movieName
        movieDescriptionLbl.text = viewModel.movieDescription
        movieImageView.round(20)
    }
}
