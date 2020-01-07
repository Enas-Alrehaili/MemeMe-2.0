//
//  MemeDetailsVC.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-25.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//

import UIKit

class MemeDetailsVC: UIViewController  {
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = self.meme.memedImage
        
    }
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
    }
    
}
