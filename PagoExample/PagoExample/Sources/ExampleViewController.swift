//
//  ViewController.swift
//  PagoExample
//
//  Created by Alex Manarpies on 06/02/16.
//  Copyright © 2016 Jarroo. All rights reserved.
//

import UIKit
import Pago

class ExampleViewController: UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        PageViewController<ExampleViewModel>().makeChildController(of: self)
    }
}

