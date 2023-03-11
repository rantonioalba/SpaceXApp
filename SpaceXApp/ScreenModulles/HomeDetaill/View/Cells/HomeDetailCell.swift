//
//  HomeDetailCell.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit

class HomeDetailCell: UICollectionViewCell {

    @IBOutlet weak var flickrImageView: CustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func configureCell(at indexPath:IndexPath, viewModel:HomeDetailViewModel) {
        let url = viewModel.flickrImageURLAtIndexPath(indexPath: indexPath)
        flickrImageView.loadImageUsingUrlString(urlString: url)
    }
}
