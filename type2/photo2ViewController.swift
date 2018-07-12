//
//  photo2ViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/07/07.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit

class photo2ViewController: UIViewController {
    
    var image: UIImage?
    @IBOutlet weak var imageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = image
//        imageView1.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    @IBAction func backbutton2(_ sender: UIButton) {
        
        imageView1.image = nil
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    

}
