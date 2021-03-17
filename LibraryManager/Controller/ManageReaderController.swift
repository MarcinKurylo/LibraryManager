//
//  ManageReaderController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Cocoa

class ManageReaderController: NSViewController, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var readerFirstName: NSTextField!
    @IBOutlet weak var readerLastName: NSTextField!
    var results : [Reader] = []
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    @IBAction func searchClicked(_ sender: NSButton) {
        if !inputManager.isValidString(readerFirstName) && !inputManager.isValidString(readerLastName){
            results = realm.search(object: Reader.init(), with: nil)
            tableView.reloadData()
        } else {
            let filter = inputManager.makeReaderFilter(firstName: readerFirstName, lastName: readerLastName)
            results = realm.search(object: Reader.init(), with: filter)
            inputManager.clearInput(readerFirstName)
            inputManager.clearInput(readerLastName)
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.action = #selector(onItemClicked)
    }
    override func viewWillAppear() {
        results = realm.search(object: Reader.init(), with: nil)
        tableView.reloadData()
    }
    @objc private func onItemClicked() {
        if (tableView.clickedRow > -1){
            performSegue(withIdentifier: "DisplayReaderDetails", sender: tableView.cell)
        }
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let readerDetailsVC = segue.destinationController as! ReaderDetailsController
        let row = tableView.clickedRow
        let toSend = results[row]
        readerDetailsVC.reader = toSend
        readerDetailsVC.parentVC = self
    }
}
extension ManageReaderController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return results.count
    }
    fileprivate enum CellIdentifiers {
        static let IdCell = "ReaderID"
        static let FirstNameCell = "ReaderFirstName"
        static let LastNameCell = "ReaderLastName"
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier : String?
        switch tableColumn{
        case tableView.tableColumns[0]:
            cellIdentifier = CellIdentifiers.IdCell
        case tableView.tableColumns[1]:
            cellIdentifier = CellIdentifiers.FirstNameCell
        case tableView.tableColumns[2]:
            cellIdentifier = CellIdentifiers.LastNameCell
        default:
            cellIdentifier = nil
        }
        if let cell = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue: cellIdentifier!), owner: nil) as? NSTableCellView {
            switch cellIdentifier{
            case CellIdentifiers.IdCell:
                cell.textField?.stringValue = results[row].id
                return cell
            case CellIdentifiers.FirstNameCell:
                cell.textField?.stringValue = results[row].getFirstName()
                return cell
            case CellIdentifiers.LastNameCell:
                cell.textField?.stringValue = results[row].getLastName()
                return cell
            default:
                return nil
            }
        }
        return nil
    }
    
}

