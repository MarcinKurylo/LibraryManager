//
//  BookModel.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 14/03/2021.
//

import Foundation
import RealmSwift

class Book : Object{
    
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var title : String = ""
    @objc dynamic var author : String = ""
    @objc dynamic var releaseYear : Int = 0
    @objc dynamic var placeCode : String = ""
    @objc dynamic var reserved : Bool = false
    
     
    public func getTitle() -> String {
        return self.title
    }
    
    public func getAuthor() -> String {
        return self.author
    }
    
    public func getReleaseYear() -> Int {
        return self.releaseYear
    }
    
    public func getPlaceCode() -> String {
        return self.placeCode
    }
    
    public func isReserved() -> Bool {
        return self.reserved
    }
    
    public func reserveBook() -> Bool {
        if (!isReserved()) {
            self.reserved = true
            return true
        }
        return false
    }
    
    public func returnBook() -> Bool {
        if (isReserved()) {
            self.reserved = false
            return true
        }
        return false
    }
    public func toString() -> String{
        return "\(self.title) by \(author), release year - \(releaseYear)"
    }
    
}
