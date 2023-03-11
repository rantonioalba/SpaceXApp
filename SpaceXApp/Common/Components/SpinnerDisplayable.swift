//
//  SpinnerDisplayable.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import UIKit

protocol SpinnerDisplayable : AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension SpinnerDisplayable where Self : UIViewController {
    private var parentView: UIView {
        navigationController?.view ?? view
    }
    
    private var doesNotExistAnotherSpinner : Bool {
        parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
    }
    
    func showSpinner()  {
        guard doesNotExistAnotherSpinner else {
            return
        }
        configureSpinner()
    }
    
    func hideSpinner() {
        if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
            foundView.removeFromSuperview()
        }
    }
    
    private func configureSpinner() {
        let containerView = UIView()
        containerView.tag = ViewValues.tagIdentifierSpinner
        parentView.addSubview(containerView)
        containerView.fillSuperView()
        containerView.backgroundColor = .black.withAlphaComponent(ViewValues.opacityContainerSpinner)
        addSpinnerIndicatorToContainer(containerView: containerView)
    }
    
    private func addSpinnerIndicatorToContainer(containerView: UIView){
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        containerView.addSubview(spinner)
        spinner.centerXY()
    }
}

