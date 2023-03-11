//
//  HomeView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import UIKit
import Combine

class HomeView: UIViewController {
    var viewModel :  HomeViewModel!
    var cancellables = Set<AnyCancellable>()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stateController()
        setupView()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = ""
//        navigationItem.hidesBackButton = true
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.frame = UIScreen.main.bounds
    }
            
    func setupView() {
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        self.navigationItem.titleView = titleView
        tableView.register(UINib(nibName: "HomeViewCell", bundle: Bundle.main), forCellReuseIdentifier: "homeViewCell")
    }
    
    func stateController()  {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
            switch state {
            case .success:
                self?.hideSpinner()
                self?.tableView.reloadData()
                break
            case .loading:
                self?.showSpinner()
                break
            case .fail(error: _):
                self?.hideSpinner()
                break
            }
        }.store(in: &cancellables)
    }
}

extension HomeView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: 0)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeViewCell", for: indexPath) as? HomeViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.configureCellAtIndexPath(indexPath: indexPath, viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.text = "    Launches past"
        label.textColor = UIColor(red: 10/255.0, green: 8/255.0, blue: 123/255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelectedAtIndexPath(indexPath:indexPath)
    }
}

extension HomeView : SpinnerDisplayable { }
