//
//  SearchResultTableViewController.swift
//  iTunesSearch
//
//  Created by Steven Leyva on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultController = SearchResultController()
    
    @IBOutlet weak var iTunesSegmentedContol: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text, !input.isEmpty else { return }
        var resultType: ResultType!
        switch iTunesSegmentedContol.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .none
        }
        
        searchResultController.performSearch(searchTerm: input, resultType: resultType) { (error) in
            if let  error = error {
                NSLog("Search term not found: \(error)")
                return
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)

        let searchResult = searchResultController.searchResult[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
}
