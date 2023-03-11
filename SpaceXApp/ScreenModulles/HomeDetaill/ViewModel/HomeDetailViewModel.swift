//
//  HomeDetailViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import Foundation
import Combine

protocol HomeDetailViewModelProtocol : BaseViewModel {
    var missionName: String { get }
    var missionDate: String { get }
    var siteName: String { get }
    var rocketName:  String { get }
    var rocketType: String { get }
    var numberOfFlickersImages: Int { get }
    var details: String? { get }
    func flickrImageURLAtIndexPath(indexPath:IndexPath) -> String
    func viewDidDisappear()
    func playVideo()
    func showInfo()
}

final class HomeDetailViewModel: HomeDetailViewModelProtocol {
    @Published var isFlickrImagesHidden = false
    @Published var isVideoHidden = false
    private weak var coordinator:DetailCoordinator?
    var state: PassthroughSubject<StateController, Never>
    private var launch:CRocketLaunch
    private var arrayFlickrImages:[String]?
    
        
    var missionName: String {
        return launch.missionName ?? ""
    }
    
    var missionDate: String {
        get {
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"

            if let date = dateFormatter.date(from: launch.launchDateUTC ?? "") {
                dateFormatter.dateFormat = "'Date:' MMM d, HH:mm a"
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.amSymbol = "a.m."
                dateFormatter.pmSymbol = "p.m."
                let localDate =  dateFormatter.string(from: date)
                return  localDate
            }
            return ""
        }
    }
    
    var siteName: String {
        get { return "Site: \(launch.launchSite?.siteNameLong ?? "")" }
    }

    var rocketName:  String {
        get { return "Rocket name: \(launch.rocket?.rocketName ?? "")" }
    }

    var rocketType: String {
        get { return "Rocket type: \(launch.rocket?.rocketType ?? "")"}
    }
    
    var numberOfFlickersImages: Int {
        get { 
            return arrayFlickrImages?.count ?? 0 }
    }
    
    func flickrImageURLAtIndexPath(indexPath:IndexPath) -> String {
        return arrayFlickrImages?[indexPath.row] ?? ""
    }
    
    var details: String? {
        get { return launch.details ?? "" }
    }
         
    init (coordinator:DetailCoordinator, state: PassthroughSubject<StateController, Never>, launch:CRocketLaunch) {
        self.coordinator = coordinator
        self.state = state
        self.launch = launch
    }
    
    func viewDidLoad() {
        arrayFlickrImages = launch.links?.flickrImages as? [String]
                        
        if arrayFlickrImages?.count ?? 0 > 0 {
            self.isFlickrImagesHidden = false
        } else {
            self.isFlickrImagesHidden = true
        }
        
        if launch.links?.youtubeID == nil && launch.links?.videoLink == nil {
            self.isVideoHidden = true
        } else {
            self.isVideoHidden = false
        }
    }
    
    func viewDidDisappear()  {
        coordinator?.didFinishDetail()
    }
    
    func playVideo()  {
        coordinator?.startVideo()
    }
    
    func showInfo() {
        coordinator?.startInfo()
    }
}
