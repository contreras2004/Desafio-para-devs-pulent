//
//  SongsView.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit

class SongsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

import UIKit

protocol SongsCollectionViewDelegate{
    func didTap(cell: SongCollectionViewCell)
}

class SongsCollectionView: UIView {
    var delegate : SongsCollectionViewDelegate? = nil
    var cellReuseId = "SongCollectionViewCell"
    //let favorites = DataManager().retrieve(decodingType: Favorites.self, storingKey: Favorites().key)
    @IBOutlet weak var collectionView: UICollectionView!
    
    var songs : [Song] = [Song]() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        debugPrint("init del SongsCollectionView")
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
    }
}

extension SongsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugPrint("cellForItemAt")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as?  SongCollectionViewCell {
            cell.delegate = self //sets the delegate so we are able to receive touch events from it
            cell.song = self.songs[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //pass the cell to the delegate
        if let cell = collectionView.cellForItem(at: indexPath) as? SongCollectionViewCell{
            delegate?.didTap(cell: cell)
        }
    }
}


extension SongsCollectionView: SongCollectionViewCellDelegate{
    func didTap(cell: SongCollectionViewCell) {
        debugPrint("did tap cell")
    }
}
