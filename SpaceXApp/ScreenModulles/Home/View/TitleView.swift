//
//  TitleView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit

class TitleView: UIView {
    let imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "rocket"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle : UILabel = {
        let view = UILabel()
        view.text = "Space X"
        view.textColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        addSubview(imageView)
        addSubview(labelTitle)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -15).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 90).isActive = true
        labelTitle.centerY()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerY()
        imageView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.isHidden = false
    }
}
