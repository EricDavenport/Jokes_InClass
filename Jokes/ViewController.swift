//
//  ViewController.swift
//  Jokes
//
//  Created by Eric Davenport on 12/3/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadJokes()
  }
  
  func loadJokes() {
    // trailing closure syntax
    JokesAPIClient.fetchJokes{ result in
      switch result {
      case .failure(let error):
        // create a UIAlertController to present to the user
        let alertController = UIAlertController.init(title: "Network Error", message: "\(error)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // always update UI on the main thread
        DispatchQueue.main.async {
        self.present(alertController, animated: true, completion: nil)
        }
      case .success(let jokes):
        dump(jokes)
      }
    }
  }
  
}

