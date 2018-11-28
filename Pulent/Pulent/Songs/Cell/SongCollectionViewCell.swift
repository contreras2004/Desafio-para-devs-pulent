//
//  SongCollectionViewCell.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit

protocol SongCollectionViewCellDelegate{
    func didTap(cell: SongCollectionViewCell)
}

class SongCollectionViewCell: UICollectionViewCell {
    var delegate : SongCollectionViewCellDelegate? = nil
    var song: Song? = nil {
        didSet{
            debugPrint("received song")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
