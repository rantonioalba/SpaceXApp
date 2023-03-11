//
//  InfoView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import UIKit
import WebKit

class InfoView: UIViewController {
    var viewModel: InfoViewModel!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = viewModel.getArticleLinkURL()
        
        guard let link = URL(string: link) else {
            return
        }
        
        let request = URLRequest(url: link)
        webView.load(request)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        viewModel.viewDidDisappear()
    }
}
