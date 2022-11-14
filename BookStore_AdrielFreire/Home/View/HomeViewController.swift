//
//  HomeViewController.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel

    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
