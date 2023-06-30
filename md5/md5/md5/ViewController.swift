//
//  ViewController.swift
//  md5
//
//  Created by gmy on 2023/6/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mainMd5 = MD5Handler.mainBundleMd5()
        print("mainMd5" + ":" + mainMd5)
        
        print("md5")
    }


}

