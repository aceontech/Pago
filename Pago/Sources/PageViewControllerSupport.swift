//
//  PageViewControllerSupport.swift
//  Pago
//
//  Created by Alex Manarpies on 05/02/16.
//

import Foundation

public extension UIViewController {
	func makeChildController(of controller: UIViewController?) {
		if let c = controller {
			c.addChildViewController(self)
			c.view.addSubview(self.view)
		}
	}
}

/**
 View controllers that participate in the page view controller system can opt to implement
 this protocol. Doing so will cause the associated `Page` model object to be injected.
 */
public protocol PageAwareController {
	var page: Page? { get set }
}

/**
 View controllers that participate in the page view controller system can adopt this protocol to
 get their parent page view controller's view model injected. Simply add the following
 properties to do so:

 - `viewModel?`: Any matching view model that implements `PageControllerViewModel`
 */
public protocol PageViewModelAwareController {
	// Note (Swift 2.0):
	// -----------------
	// Can't use associated type here because this will prevent us from using this protocol
	// as a type (as oppposed to a generic type constraint).

	// Using PageViewControllerViewModel protocol instead, but this type is too general and
	// will and will need to be downcasted in the controller implementation. This is obviously
	// a workaround which I hope a future version of Swift will solve.
	//
	// typealias ViewModelType
	// var viewModel:ViewModelType { get set }

	var viewModel: PageViewControllerViewModel? { get set }
}