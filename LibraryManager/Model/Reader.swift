//
//  Reader.swift
//  Library
//
//  Created by Marcin Kuryło on 14/03/2021.
//

import Foundation
import RealmSwift

class Reader : Object{
    
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var firstName : String = ""
    @objc dynamic var lastName : String = ""
    var books = RealmSwift.List<Book>()
    
    
    public func getFirstName() -> String {
        return self.firstName
    }
    
    public func getLastName() -> String {
        return self.lastName
    }
    
    private func getBooksCopy() -> [Book] {
        return self.books.map({$0})
    }
    
    public func addBook(book : Book) -> [Book] {
        var booksCopy = getBooksCopy()
        if (booksCopy.count < 5 && !book.isReserved()){
            booksCopy.append(book)
        }
        return booksCopy
    }
    public func removeBook(book : Book) -> [Book] {
        var booksCopy = getBooksCopy()
        booksCopy.removeAll(where: {$0.id == book.id})
        return booksCopy
    }
}
