//
//  HomeViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import Foundation
import Combine
import UIKit
import CoreData

protocol HomeViewModelProtocol : BaseViewModel {
    func numberOfItemsInSection(section:Int) -> Int
    func missionPatchSmallAtIndexPath(indexPath:IndexPath) -> String
    func misionNameAtIndexPath(indexPath:IndexPath) -> String
    func siteNameAtIndexPath(indexPath:IndexPath) -> String
    func dateLaunchAtIndexPath(indexPath:IndexPath) -> String
    func cellSelectedAtIndexPath(indexPath:IndexPath)
}

final class HomeViewModel: NSObject, HomeViewModelProtocol {
    var state: PassthroughSubject<StateController, Never>
    private var coordinator:HomeCoordinator
    private var fetchedResultsController: NSFetchedResultsController<CRocketLaunch>?
    
    func numberOfItemsInSection(section:Int) -> Int {
        guard let launches = fetchedResultsController?.fetchedObjects else { return 0 }
            return launches.count
    }
    
    func missionPatchSmallAtIndexPath(indexPath:IndexPath) -> String {
        return fetchedResultsController?.object(at: indexPath).links?.missionPatchSmall ?? ""
    }
    
    func misionNameAtIndexPath(indexPath:IndexPath) -> String {
        return fetchedResultsController?.object(at: indexPath).missionName ?? ""
    }
    
    func siteNameAtIndexPath(indexPath:IndexPath) -> String {
        return fetchedResultsController?.object(at: indexPath).launchSite?.siteName ?? ""
    }
    
    func dateLaunchAtIndexPath(indexPath:IndexPath) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"

        if let date = dateFormatter.date(from: fetchedResultsController?.object(at: indexPath).launchDateUTC ?? "") {
            dateFormatter.dateFormat = "EEEE, MMM. dd, yyyy"
            dateFormatter.locale = Locale(identifier: "es_MX")
            let localDate =  dateFormatter.string(from: date)
            return localDate
        }
        return ""
    }
    
    func cellSelectedAtIndexPath(indexPath:IndexPath)  {
        guard let rocketLaunchSelected = fetchedResultsController?.object(at: indexPath) else {
            return
        }
        coordinator.startDetail(rocketLaunch: rocketLaunchSelected)
    }
    

    init (coordinator:HomeCoordinator, state: PassthroughSubject<StateController, Never>) {
        self.state = state
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        state.send(.loading)
        validateLoadData()
    }
        
    private func validateLoadData()  {
        let userDefaults = UserDefaults.standard

        if let dateSavedString = userDefaults.string(forKey: "dateSaved") {
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "yyyy-MM-dd"

            let dateSaved =  dataFormatter.date(from: dateSavedString)
            let dateNow = Date.now
            
            let dateStringNow = dataFormatter.string(from: dateNow)
            let dateNowFormatted = dataFormatter.date(from: dateStringNow)

            if dateSaved == dateNowFormatted {
                fetchedResultsController = CoreDataManager.sharedInstance.getFetcheResultsController()
                do {
                    try fetchedResultsController?.performFetch()
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                loadData()
            }
        } else {
            loadData()
        }
        state.send(.success)
    }
    
    private func loadData() {
        Task {
            do {
                CoreDataManager.sharedInstance.removeData()
                let request = RequestModel(queryItems: nil, httpMethod: .get, apiURL: APIURL.LAUNCHES)
                let launches = try await ServiceLayer.sharedInstance.callService(request, CRocketLaunch.self)
                if let _ = launches {
                    CoreDataManager.sharedInstance.saveData()
                    fetchedResultsController = CoreDataManager.sharedInstance.getFetcheResultsController()
                    
                    do {
                        try fetchedResultsController?.performFetch()
                        let userDefaults = UserDefaults.standard
                        let dateNow = Date.now
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        
                        let dateString = dateFormatter.string(from: dateNow)
                        print(dateString)
                        userDefaults.set(dateString, forKey: "dateSaved")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                state.send(.success)
            } catch {
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
}

extension HomeViewModel : NSFetchedResultsControllerDelegate {
    
}
