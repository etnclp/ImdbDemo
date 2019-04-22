//
//  FilterViewController.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController, BindableType {
    
    // MARK: - Properties
    
    var viewModel: FilterViewModel!
    
    private(set) var disposeBag = DisposeBag()
    
    private var picker: UIPickerView!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var typeTextField: UITextField!
    @IBOutlet weak private var yearTextField: UITextField!
    @IBOutlet weak private var searchButton: UIButton!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Arama"
    }
    
    // MARK: - Binding
    
    func bindViewModel() {
        // Subscribing to the observer for errors.
        viewModel.error
            .subscribe(onNext: { error in
                switch error {
                case .validation(let validationError):
                    Utils.showGlobalError(target: self, message: validationError.errorMessage)
                }
                log.error("Error: \(error)")
            })
            .disposed(by: disposeBag)
        
        // Binding the title to ViewModel.
        titleTextField.rx.text
            .bind(to: viewModel.titleFilter)
            .disposed(by: disposeBag)
        
        picker = UIPickerView()
        
        let filterTypes: [ContentType] = [.all, .movie, .series, .episode]
        
        // Creating an observer according to filter types for bind to UIPickerView.
        Observable.just(filterTypes)
            .bind(to: picker.rx.itemTitles) { (row, item) in
                return item.title
            }
            .disposed(by: self.disposeBag)
        
        // Creating an observer for the selected item in the UIPickerView.
        let observable = picker.rx
            .modelSelected(ContentType.self)
            .map { $0.first! }
            .share(replay: 1)
        
        // Binding selected item to ViewModel.
        observable
            .bind(to: viewModel.typeFilter)
            .disposed(by: disposeBag)
        
        // Binding selected item title to UITextField.
        observable
            .map { $0.title }
            .bind(to: self.typeTextField.rx.text)
            .disposed(by: disposeBag)
        
        typeTextField.inputView = picker
        
        // Binding the year to ViewModel.
        yearTextField.rx.text
            .bind(to: viewModel.yearFilter)
            .disposed(by: disposeBag)
        
        // Binding to the trigger in ViewModel when tapping search button.
        searchButton.rx.tap
            .bind(to: viewModel.searchButtonTrigger)
            .disposed(by: disposeBag)
    }

}
