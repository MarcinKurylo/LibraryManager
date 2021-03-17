//
//  InputValidatorModel.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Foundation
import Cocoa

class InputManagerModel{
    
    func isValidString(_ input : NSTextField) -> Bool {
        return !input.stringValue.isEmpty
    }
    func isValidInt(_ input : NSTextField) -> Bool {
        return Int(input.stringValue) != nil
    }
    func clearInput(_ input : NSTextField) {
        input.stringValue = ""
    }
    func getInput(_ input : NSTextField) -> String{
        return input.stringValue
    }
    func makeReaderFilter(firstName : NSTextField, lastName : NSTextField) -> String {
        var filter = ""
        if isValidString(firstName) {
            filter += "AND firstName == '\(getInput(firstName))' "
        }
        if isValidString(lastName) {
            filter = "AND lastName == '\(getInput(lastName))' "
        }
        filter.removeFirst(4)
        return filter
    }
    func makeBookFilter(bookTitle : NSTextField, bookAuthor : NSTextField, bookReleaseYear : NSTextField, bookShelfCode : NSTextField) -> String {
        var filter = ""
        if isValidString(bookTitle){
            filter += "AND title == '\(getInput(bookTitle))' "
        }
        if isValidString(bookAuthor){
            filter += "AND author == '\(getInput(bookAuthor))' "
        }
        if isValidInt(bookReleaseYear){
            filter += "AND releaseYear == \(getInput(bookReleaseYear)) "
        }
        if isValidString(bookShelfCode){
            filter += "AND placeCode == '\(getInput(bookShelfCode))' "
        }
        filter.removeFirst(4)
        return filter
    }
    func makeBookFilter(bookID : NSTextField, bookTitle : NSTextField) -> String {
        var filter = ""
        if isValidString(bookTitle){
            filter += "AND title == '\(getInput(bookTitle))' "
        }
        if isValidString(bookID){
            filter += "AND id == '\(getInput(bookID))' "
        }
        filter += "AND reserved == 0" // We need only array of available books
        filter.removeFirst(4)
        return filter
    }
}
