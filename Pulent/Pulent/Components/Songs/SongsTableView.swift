//
//  SongsView.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit

protocol SongsTableViewDelegate{
    func didTap(cell: SongTableViewCell)
    func tableViewScrolledToEnd()
}

class SongsTableView: UIView {
    var delegate : SongsTableViewDelegate? = nil
    var cellReuseId = "SongTableViewCell"
    //let favorites = DataManager().retrieve(decodingType: Favorites.self, storingKey: Favorites().key)
    @IBOutlet weak var tableView: UITableView!
    
    var songs : [Song] = [Song]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var itemsPerPage: Int = 20 //by default we set 20
    var tabieViewBottomSpinner : UIActivityIndicatorView? = nil
    
    override init(frame: CGRect) {
        debugPrint("init del SongsTableView")
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        debugPrint("init?(coder aDecode")
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        debugPrint("commonInit")
        fromNib()
        let cellNib = UINib(nibName: cellReuseId, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellReuseId)
        
        //setup the loader at the bottom of the TableView
        tabieViewBottomSpinner = UIActivityIndicatorView(style: .gray)
        tabieViewBottomSpinner?.startAnimating()
        tabieViewBottomSpinner?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
    }
    
    func showLoadingInTableView(show: Bool){
        self.tableView.tableFooterView?.isHidden = show
        if show{
            self.delegate?.tableViewScrolledToEnd()
            self.tableView.tableFooterView = tabieViewBottomSpinner
        }
        else{
            //self.tableViewMiddleSpinner.stopAnimating()
            UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                self.tableView.tableFooterView?.frame.size.height = 0
            }) { (true) in
                self.tableView.tableFooterView = UIView()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            showLoadingInTableView(show: true)
        }
    }
}

extension SongsTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ TableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = TableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as?  SongTableViewCell {
            cell.delegate = self //sets the delegate so we are able to receive touch events from it
            cell.song = self.songs[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //pass the cell to the delegate
        if let cell = tableView.cellForRow(at: indexPath) as? SongTableViewCell{
            delegate?.didTap(cell: cell)
        }
    }
}


extension SongsTableView: SongTableViewCellDelegate{
    func didTap(cell: SongTableViewCell) {
        debugPrint("did tap cell")
    }
}
