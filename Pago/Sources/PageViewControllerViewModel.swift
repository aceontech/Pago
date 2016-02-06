//
//  PageViewModel.swift
//  Pago
//
//  Created by Alex Manarpies on 05/02/16.
//

import Foundation

// MARK:  Models -

/**
    Tuple for identifying a storyboard resource
*/
typealias StoryboardResource = (storyboard:String, id:String)

/**
    Defines what a `Page` is. Models participating in the paging system need to adopt
    at least this protocol.
*/
protocol Page {
    var id:String { get set }
    var storyboardResource:StoryboardResource { get set }
}

/**
    Most elementaty value-type implementation of a page
**/
struct BasicPage : Page {
    var id:String
    var storyboardResource:StoryboardResource
}

// MARK: - PageViewController model -

/**
    Defines the contract for view models of PageViewController. View models participating
    in the paging system must adopt this protocol
*/
protocol PageViewControllerViewModel {
    var pages:[Page] { get set }
    
    func indexOfPageById(id:String) -> Int?
    func pageById(id:String) -> Page?
    func pageAtIndex(index:Int) -> Page?
    
    init()
}

/**
    Adds a default implementation for the PageViewControllerViewModel protocol.
*/
extension PageViewControllerViewModel {
    func pageAtIndex(index:Int) -> Page? {
        if(index > -1 && index < self.pages.count) {
            return self.pages[index]
        }
        return nil
    }
    
    func pageById(id:String) -> Page? {
        return self.pages.filter({ (page) -> Bool in
            return page.id == id
        }).first
    }
    
    func indexOfPageById(id:String) -> Int? {
        return self.pages.indexOf({ (page) -> Bool in
            page.id == id
        })
    }
}