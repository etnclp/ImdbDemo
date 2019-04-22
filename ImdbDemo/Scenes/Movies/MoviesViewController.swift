//
//  MoviesViewController.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Kingfisher
import UIKit
import RxSwift

class MoviesViewController: UIViewController, BindableType {
    
    // MARK: - Properties
    
    var viewModel: MoviesViewModel!
    
    private(set) var disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Arama Sonuçları"

        SearchCell.register(to: tableView)
    }
    
    // MARK: - Binding
    
    func bindViewModel() {
        viewModel.nextPageTrigger.onNext(())
        
        // Binding the search results to the UITableView.
        viewModel.elements
            .bind(to: tableView.rx.items(cellType: SearchCell.self))
            { (row, element, cell) in
                cell.movieImageView.kf.indicatorType = .activity
                cell.movieImageView.kf.setImage(with: URL(string: element.poster), placeholder: UIImage())
                cell.titleLabel.text = element.title
                cell.yearLabel.text = element.year
                cell.typeLabel.text = element.type.title
            }
            .disposed(by: disposeBag)
        
        // Subscribing to the observer for errors.
        viewModel.error
            .subscribe(onNext: { error in
                log.error("Error: \(error)")
            })
            .disposed(by: disposeBag)
        
        // Triggers the next page when reaches the end of the page in UITableView.
        tableView.rx.reachedBottom
            .bind(to: viewModel.nextPageTrigger)
            .disposed(by: disposeBag)
        
        // Sets UITableView delegation.
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchCell.Height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchCell.EstimatedHeight
    }
    
}
