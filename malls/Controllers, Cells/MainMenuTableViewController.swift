//
//  MainMenuTableViewController.swift
//  malls
//
//  Created by Anna Nosyk on 19.01.2021.
//

import UIKit
import RealmSwift

class MainMenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let searchController = UISearchController(searchResultsController: nil)
    private var malls: Results<Malls>!
    private var filterItems: Results<Malls>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sortBarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        malls = realm.objects(Malls.self)
        
        //setup search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - tableView data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering  {
            return filterItems.count
        }
        return malls.isEmpty ? 0 :  malls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        var mall = Malls()
        
        if isFiltering {
            mall = filterItems[indexPath.row]
        } else {
            mall = malls[indexPath.row]
        }
        cell.nameLabel.text = mall.name
        cell.locationLabel.text = mall.location
        cell.imageOfMall.image = UIImage(data: mall.imageData!)
        
        cell.imageOfMall.layer.cornerRadius = cell.imageOfMall.frame.size.height/2
        cell.imageOfMall.clipsToBounds = true
        return cell
    }
    // MARK: - tableView Delegate
    
    //delete rows
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //delete rows from tableView and Database
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let mall = malls[indexPath.row]
            StorageManager.deleteObject(mall)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let mall : Malls
            
            if isFiltering {
                mall = filterItems[indexPath.row]
            } else {
                mall = malls[indexPath.row]
            }
            
            let detailVC = segue.destination as! NewMallController
            detailVC.currentItem = mall
        }
    }
    
    
    //save new value for  items
    @IBAction func unwidSegue(_ segue: UIStoryboardSegue) {
        
        guard let newMallVC = segue.source as? NewMallController else { return }
        
        newMallVC.saveMall()
        tableView.reloadData()
    }
    
    // sorting by name or date
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    // ascending sorting
    @IBAction func reversedSorting(_ sender: Any) {
        
        //reverse the value
        ascendingSorting.toggle()
        
        if ascendingSorting {
            sortBarBtn.image = #imageLiteral(resourceName: "AZ")
        } else {
            sortBarBtn.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            malls = malls.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            malls = malls.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
    
}

// MARK: - SearchController

extension MainMenuTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    //for filter content
    private func filterContentForSearchText(_ searchText: String) {
        
        filterItems = malls.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        
        tableView.reloadData()
    }
    

    
}
