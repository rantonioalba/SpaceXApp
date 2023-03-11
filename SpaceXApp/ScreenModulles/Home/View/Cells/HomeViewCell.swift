//
//  HomeViewCell.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageMission: CustomImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCellAtIndexPath(indexPath:IndexPath, viewModel:HomeViewModel) {
        
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 5.0
        
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 5.0
        
                
        imageMission.loadImageUsingUrlString(urlString: viewModel.missionPatchSmallAtIndexPath(indexPath: indexPath))
        missionNameLabel.text = viewModel.misionNameAtIndexPath(indexPath: indexPath)
        siteNameLabel.text = viewModel.siteNameAtIndexPath(indexPath: indexPath)
        launchDateLabel.text = viewModel.dateLaunchAtIndexPath(indexPath: indexPath)
    }
}
