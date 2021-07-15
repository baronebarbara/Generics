//
//  ViewController.swift
//  Generics
//
//  Created by Barbara Barone on 15/07/21.
//

import UIKit

struct Repository: Decodable {
    let id: Int
    let name: String
    let fullName: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service<Repository>().method { result in
            switch result {
            case .success(let repositories):
                print(repositories)
            case .failure(let error):
                print(error)
            }
        }
    }
}

