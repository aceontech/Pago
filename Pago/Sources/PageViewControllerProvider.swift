//
//  PageViewController.swift
//  Pago
//
//  Created by Alex Manarpies on 05/02/16.
//

import Foundation

/**
 A adopts `UIPageViewControllerDataSource` and `UIPageViewControllerDelegate` and knows
 how to work with pages.
 */
class PageViewControllerProvider: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	typealias PageChangedHandler = (index: Int) -> ()

	/**
	 Reference to page view controller under management
	 */
	private(set) weak var pageViewController: UIPageViewController?

	/**
	 The model used for supplying data to this provider. This can be a view model, or any
	 other object that implements the `PageViewControllerProviderModel`
	 */
	private(set) var model: PageViewControllerViewModel

	/**
	 Internal map of instantiated page view controllers
	 */
	private lazy var pageControllers = Dictionary<String, UIViewController>()

	/**
	 Keeps track of what the next page index will be.
	 */
	private var nextIndex = 0

	// MARK: - Event Handlers

	var pageChangedHandler: PageChangedHandler?

	init(pageViewController: UIPageViewController, model: PageViewControllerViewModel) {
		self.pageViewController = pageViewController
		self.model = model
		super.init()

		if let controller = self.pageViewController {
			controller.dataSource = self
			controller.delegate = self
		}
	}

	func controllerForPage(p: Page?) -> UIViewController? {
		if let page = p {
			if let cachedController = self.pageControllers[page.id] {
				return cachedController
			} else {
				let newController = page.storyboardResource.storyboard.instantiateViewControllerWithIdentifier(page.storyboardResource.id)
				self.pageControllers[page.id] = newController
				return newController
			}
		}
		return nil
	}

	// MARK: - UIPageViewControllerDataSource

	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		let nextController = controllerFollowedBy(viewController, direction: .After)
		return nextController
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		let previousController = controllerFollowedBy(viewController, direction: .Before)
		return previousController
	}

	// MARK: - UIPageViewControllerDelegate

	func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
		if let nextController = pendingViewControllers.first, nextPage = pageForController(nextController), nextIndex = self.model.indexOfPageById(nextPage.id) {
			self.nextIndex = nextIndex
		}
	}

	func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if (completed) {
			if let handler = self.pageChangedHandler {
				handler(index: self.nextIndex)
			}
		}
	}

	// MARK: - Util

	private enum ControllerJumpDirection: Int {
		case After = 1
		case Before = -1
	}

	private func controllerFollowedBy(viewController: UIViewController, direction: ControllerJumpDirection) -> UIViewController? {
		if let currentPage = pageForController(viewController), currentIndex = self.model.indexOfPageById(currentPage.id) {
			let nextIndex = currentIndex + direction.rawValue
			if (nextIndex > -1 && nextIndex < self.model.pages.count) {
				let nextPage = self.model.pageAtIndex(nextIndex)
				if let nextController = controllerForPage(nextPage) {
					// Inject page if controller is aware
					if var pageAwareController = nextController as? PageAwareController {
						pageAwareController.page = nextPage
					}

					// Inject view model is controller is aware
					// TODO
					if var viewModelAwareController = nextController as? PageViewModelAwareController {
						viewModelAwareController.viewModel = self.model
					}

					return nextController
				}
			}
		}
		return nil
	}

	private func pageForController(controller: UIViewController) -> Page? {
		let results = self.pageControllers.filter { (pageId, pageController) -> Bool in
			return controller == pageController
		}.first

		if let pageControllerPair = results {
			return self.model.pageById(pageControllerPair.0)
		}
		return nil
	}
}
