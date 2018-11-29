//
//  ViewController.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit

class SongsViewController: BaseViewController {
    
    enum Segues: String{
        case toDetails
    }
    
    @IBOutlet weak var songsTableView: SongsTableView!
    var songsRequestModel = SearchSongRequestModel()
    var searchTerm = ""
    var selectedSong : Song? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songsTableView.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    func fetchSongs(searchTerm: String){
        //delete all songs if the searchTerm has changed
        if searchTerm != self.searchTerm{
            songsTableView.songs.removeAll()
        }
        
        //configure the request
        debugPrint("The search term wil be: \(searchTerm)")
        songsRequestModel.term = searchTerm
        songsRequestModel.offset = songsTableView.songs.count
        // Do any additional setup after loading the view, typically from a nib.
        SongsManager.shared.fetchSongs(searchSongRequestModel: songsRequestModel) { (songs, error) in
            //save the searchTerm temporarily so we can scroll down and search again but with offset
            self.searchTerm = searchTerm
            if let error = error{
                debugPrint("Error fetching data: \(error)")
                self.songsTableView.showLoadingInTableView(show: false)
                return
            }
            if let songs = songs{
                self.addSongsToTableView(songs: songs)
            }
        }
    }
    
    func addSongsToTableView(songs: [Song]){
        //check if the songs are already in the array
        debugPrint("Songs: \(songs.count)")
        let diferenceArray = songs.filter { !self.songsTableView.songs.contains($0) }
        if diferenceArray.count > 0{
            self.songsTableView.removeMessage()
            self.songsTableView.songs = self.songsTableView.songs + diferenceArray
            self.songsRequestModel.offset = self.songsRequestModel.offset + songs.count
            self.songsTableView.showLoadingInTableView(show: false)
        }
        else{
            self.songsTableView.showMessage(type: .noSearchResults)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebViewController{
            destination.title = self.selectedSong?.trackName
            destination.url = self.selectedSong?.collectionViewUrl
        }
    }
}

extension SongsViewController: SongsTableViewDelegate{
    func didTap(cell: SongTableViewCell) {
        self.selectedSong = cell.song
        self.performSegue(withIdentifier: Segues.toDetails.rawValue, sender: self)
    }
    
    func tableViewScrolledToEnd() {
        fetchSongs(searchTerm: searchTerm)
    }
}

extension SongsViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchString = searchController.searchBar.text, !searchString.isEmpty{
            fetchSongs(searchTerm: searchString.replacingOccurrences(of: " ", with: "+"))
        }
    }
}

