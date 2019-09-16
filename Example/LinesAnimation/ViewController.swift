//
//  ViewController.swift
//  LinesAnimation
//
//  Created by jainijhawan on 09/16/2019.
//  Copyright (c) 2019 jainijhawan. All rights reserved.
//

import UIKit
import LinesAnimation
class ViewController: UIViewController {
 
  override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func btnPressed(_ sender: AnimatingButton) {
    sender.animatingButton(btn: sender, tDistance: 150, withDuration: 1, numberOfLines: 8)
    
  }
}

