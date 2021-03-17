//
//  RealmModel.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Foundation
import Cocoa
import RealmSwift

class RealmModel {
    
    private let realm = try! Realm()
    
    private func add(object : Object){
        do {
            try realm.write{
                realm.add(object)
            }
        } catch {
            print("error")
        }
    }
    private func update(object : Object, property : String, with newValue : Any) {
        do {
            try realm.write{
                object[property] = newValue
            }
        } catch {
            print("error")
        }
    }
    private func delete(object : Object){
        do {
            try realm.write{
                realm.delete(object)
            }
        } catch {
            print("error")
        }
    }
    public func addReader(firstName : String, lastName : String) {
        let reader = Reader()
        reader.firstName = firstName
        reader.lastName = lastName
        add(object: reader)
    }
    public func addBook(title : String, author : String, releaseYear : String, placeCode : String ) {
        let book = Book()
        book.title = title
        book.author = author
        book.releaseYear = Int(releaseYear)!
        book.placeCode = placeCode
        add(object: book)
    }
    public func search<T : Object>(object : T, with filter : String?) -> [T]{
        if let f = filter{
            return Array(realm.objects(T.self).filter(f))
        } else {
            return Array(realm.objects(T.self))
        }
    }
    public func updateReader(reader: Reader, firstName : String?, lastName : String?){
        if let first = firstName {
            update(object: reader, property: "firstName" , with: first)
        }
        if let last = lastName {
            update(object: reader, property: "lastName" , with: last)
        }
    }
    public func addReaderBooks(reader : Reader, book : Book) -> Bool{
        if reader.books.count < 5 {
            let books = reader.addBook(book: book)
            update(object: reader, property: "books", with: books)
            update(object: book, property: "reserved", with: true)
            return true
        }
        return false
    }
    public func deleteReaderBooks(reader : Reader, book : Book){
        let books = reader.removeBook(book: book)
        update(object: reader, property: "books" , with: books)
        update(object: book, property: "reserved", with: false)
    }
        
    public func deleteReader(reader : Reader){
        delete(object: reader)
    }
    public func deleteBook(book : Book){
        delete(object: book)
    }
    public func updateBook(book: Book, title : String?, author : String?, releaseYear : Int?, placeCode : String?){
        if let t = title {
            update(object: book, property: "title" , with: t)
        }
        if let a = author {
            update(object: book, property: "author" , with: a)
        }
        if let y = releaseYear {
            update(object: book, property: "releaseYear" , with: y)
        }
        if let c = placeCode {
            update(object: book, property: "placeCode" , with: c)
        }
    }
}
