//
//  StateSelectionViewController.swift
//  Opener
//
//  Created by 김성현 on 15/08/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit

class StateSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: 액션
    
    @IBAction func entryOrExitButtonTapped(_ sender: UIButton) {
        
        let destination = storyboard!.instantiateViewController(withIdentifier: "FaceClassifierViewController") as! FaceClassifierViewController
        //instantiateViewController(identifier: "FaceClassifierViewController")
        
        if sender.tag == 0 {
            destination.isEntry = true
        } else {
            destination.isEntry = false
        }
        present(destination, animated: true, completion: nil)
    }

}
