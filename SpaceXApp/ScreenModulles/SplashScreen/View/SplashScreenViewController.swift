//
//  SplashScreenViewController.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var viewModel : SplashScreenViewModel!
    @IBOutlet weak var imageViewRocket: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewRocket.image = UIImage.gifImageWithName("Rocket Ship")
        imageViewRocket.contentMode = .scaleAspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        self.perform(#selector(didFinish), with: nil, afterDelay: 3.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    @objc func didFinish()  {
//        viewModel.didFinish()
    }
}
