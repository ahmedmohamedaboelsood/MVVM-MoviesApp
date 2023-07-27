//
//  MainTableViewCell.swift
//  MVVM project
//
//  Created by 2B on 05/05/2023.
//

import UIKit
import Kingfisher
class MainTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var movieRateLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieReleaseYearLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    
    //MARK: - Variables
    static let ID = String(describing: MainTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        cellBackgroundView.round()
        cellBackgroundView.borders(color: .black, width: 1)
        cellBackgroundView.backgroundColor = .lightGray
        movieImageView.round(5)
    }
    
    func setupCellData(viewModel: MainCellViewModel){
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: viewModel.moviePoster)
        movieNameLbl.text = viewModel.title
        movieReleaseYearLbl.text = viewModel.releaseDate
        movieRateLbl.text = "\(viewModel.rate)"
    }
    
    func setupCellDataForCoreData(data:FilmModel){
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: data.poster_path)
        movieNameLbl.text = data.title
        movieReleaseYearLbl.text = data.release_date
        movieRateLbl.text = "\(data.vote_average)"
    }
}
