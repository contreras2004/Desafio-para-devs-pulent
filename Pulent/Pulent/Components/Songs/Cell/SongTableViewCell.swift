//
//  SongTableViewCell.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit
import Kingfisher

protocol SongTableViewCellDelegate{
    func didTap(cell: SongTableViewCell)
}

class SongTableViewCell: UITableViewCell {
    var delegate : SongTableViewCellDelegate? = nil
    var song: Song? = nil {
        didSet{
            songImageView.kf.setImage(with: song?.artworkUrl100)
            albumNameLbl.text = song?.collectionName
            bandNameLbl.text = song?.artistName
            if let price = song?.trackPrice{
                priceLbl.text = "$\(price)"
            }
            
        }
    }
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var albumNameLbl: UILabel!
    @IBOutlet weak var bandNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
