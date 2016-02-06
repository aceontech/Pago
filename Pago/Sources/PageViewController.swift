//
//  PageViewController.swift
//  Pago
//
//  Created by Alex Manarpies on 05/02/16.
//

import Foundation
import UIKit

/**
    Provides a base implementation for page based view controllers. It is generically type-bound
    to the view model associated with it.

        - ViewModelType: PageViewControllerViewModel adopter
 
    **Important note**: Do NOT use this as a base class for your `UIPageViewController`s if 
    you are using Storyboards to load controllers and views, as this is not supported by Swift (2.x).
    Use composition instead.
 
    - See `UIViewController` extension in `PageViewControllerSupport.swift`
*/
class PageViewController<ViewModelType : PageViewControllerViewModel> : UIPageViewController {
    private lazy var provider:PageViewControllerProvider = { [unowned self] in
        let p = PageViewControllerProvider(pageViewController: self, model: self.viewModel)
        p.pageChangedHandler = { index in
            // Handle page change events
        }
        return p
        }()
    
    lazy var viewModel:ViewModelType = ViewModelType()
    
    init() {
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up first view controller
        if let firstController = provider.controllerForPage(self.viewModel.pages.first) {
            self.setViewControllers([firstController], direction: .Forward, animated: false, completion: nil)
        }
    }
}