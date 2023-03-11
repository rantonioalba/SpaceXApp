//
//  HomeDetailView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit
import Combine

class HomeDetailView: UIViewController {
    var viewModel :  HomeDetailViewModel!
    var cancellables = Set<AnyCancellable>()
       
    @IBOutlet weak var labelMissionDate: UILabel!
    @IBOutlet weak var labelSite: UILabel!
    @IBOutlet weak var labelRocketName: UILabel!
    @IBOutlet weak var labelRocketType: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var viewFlickrImages: UIView!
    @IBOutlet weak var viewYouTube: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createBindingWithViewModel()
        configureTableView()
        viewModel.viewDidLoad()
        setupView()        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        if self.isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }
    
    func configureTableView() {
        collectionView.register(UINib(nibName: "HomeDetailCell", bundle: .main), forCellWithReuseIdentifier: "homeDetailCell")
    }
        
    func setupView() {
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.title = viewModel.missionName
        labelMissionDate.text = viewModel.missionDate
        labelSite.text = viewModel.siteName
        labelRocketName.text = viewModel.rocketName
        labelRocketType.text = viewModel.rocketType
        labelDetails.text = viewModel.details
        pageControl.numberOfPages = viewModel.numberOfFlickersImages
    }
    
    private func createBindingWithViewModel() {
        viewModel.$isFlickrImagesHidden
            .assign(to: \.isHidden, on: viewFlickrImages)
            .store(in: &cancellables)
        
        viewModel.$isVideoHidden
            .assign(to: \.isHidden, on: viewYouTube)
            .store(in: &cancellables)
    }
    
    @IBAction func playVideo(_ sender: Any) {
        viewModel.playVideo()
    }
    
    @IBAction func showInfo(_ sender: Any) {
        viewModel.showInfo()
    }
}

extension HomeDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFlickersImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeDetailCell", for: indexPath) as? HomeDetailCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(at: indexPath, viewModel: viewModel)
        cell.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.collectionView.frame.width
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        pageControl.currentPage = currentPage
    }
}
