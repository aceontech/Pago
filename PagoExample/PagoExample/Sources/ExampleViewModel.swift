//
//  ExampleViewModel.swift
//  PagoExample
//
//  Created by Alex Manarpies on 07/02/16.
//  Copyright © 2016 Jarroo. All rights reserved.
//

import Foundation
import Pago

class ExampleViewModel : PageViewControllerViewModel {
    var pages: [Page]
    
    required init() {
        self.pages = [
            BasicPage(id: "first", storyboardResource: ("Main", "firstController")),
            BasicPage(id: "second", storyboardResource: ("Main", "secondController")),
        ]
    }
}