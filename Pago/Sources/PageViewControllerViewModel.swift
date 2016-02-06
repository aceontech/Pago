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
public typealias StoryboardResource = (storyboard:String, id:String)

/**
    Defines what a `Page` is. Models participating in the paging system need to adopt
    at least this protocol.
*/
public protocol Page {
    var id:String { get set }
    var storyboardResource:StoryboardResource { get set }
}

/**
    Most elementaty value-type implementation of a page
**/
public struct BasicPage : Page {
    public var id:String
    public var storyboardResource:StoryboardResource
    
    init(id:String, storyboardResource:StoryboardResource) {
        self.id = id
        self.storyboardResource = storyboardResource
    }
}

// MARK: - PageViewController model -

/**
    Defines the contract for view models of PageViewController. View models participating
    in the paging system must adopt this protocol
*/
public protocol PageViewControllerViewModel {
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