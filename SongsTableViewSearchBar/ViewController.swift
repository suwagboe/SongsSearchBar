//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope {
    case artist
    case song
}


class ViewController: UIViewController {

    // outlets and variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allSongs = [Song]()
    {
        didSet{
           
            tableView.reloadData()
            // if this is found nil then that means you haven't connected the tableView....
        }
    }
    
    var currentScope = SearchScope.artist

    // this holds the current search querey
    var searchQuerey = "" {
        didSet{
            switch currentScope{
            case .artist:
                allSongs = Song.loveSongs.filter {
                    $0.artist.lowercased().contains(searchQuerey.lowercased())
                }
            case .song:
                allSongs = Song.loveSongs.filter {
                    $0.name.lowercased().contains(searchQuerey.lowercased())
                }
            }
                    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func loadData() {
        allSongs = Song.loveSongs
    }
    
    func filterHeadline(_ searchText: String) {
        print("the filterHeadline function is being used")
        guard !searchText.isEmpty else {
            return
        }
        allSongs = Song.loveSongs.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    
    func checkingTheSearch(_ searchText: String) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsViewController = segue.destination as? DetailsViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // assigns the detailsController variable the selected variable from the view controller...
        detailsViewController.selectedSong = allSongs[indexPath.row]
    }
    

}
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("inside of searchbarClick")
        //to take away the keep board
        searchBar.resignFirstResponder()
        
            
                //  searchActive = false
                     // self.searchBar.endEditing(true)
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("inside of selectedScopeButtonIndex")
        switch selectedScope{
        case 0:
            currentScope = .artist
        case 1:
            currentScope = .song
        default:
            print("not within scope")
        }
        
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            print("inside of textDidChange")
            loadData()
            return
        }
        //filterHeadline(searchText)
        
        searchQuerey = searchText
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("inside of numberOfRowsInSection")
        if allSongs.count == 0 {
//            self.tableView.
            searchBar.resignFirstResponder()
            tableView.tintColor = .red
            navigationItem.title = "you entered an invalid search please try again"
        }
        else if allSongs.count > 0 {
            navigationItem.title = ""
        }
        return allSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
       let selectedSong = allSongs[indexPath.row]
        
        cell.textLabel?.text = selectedSong.name
        
        cell.detailTextLabel?.text = selectedSong.artist
        
        return cell
        
        
    }
    
}
