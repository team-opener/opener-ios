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
    var member = Member()
    var photo: UIImage?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photo
        nameLabel.text = member.name
        timeLabel.text = "\(Date())"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
