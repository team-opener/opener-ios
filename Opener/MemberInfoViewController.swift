//
//  MemberInfoViewController.swift
//  Opener
//
//  Created by 김성현 on 14/08/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit

class MemberInfoViewController: UIViewController {
    
    //MARK: 프로퍼티
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let source = segue.source as? FaceClassifierViewController else {
            return
        }
        nameLabel.text = source.memberInfo.identifier
        confidenceLabel.text = "\(source.memberInfo.confidence * 100)%"
        photoImageView.image = source.capturedPhoto
    }

}
