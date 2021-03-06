//
//  CharactersViewController.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 16/1/21.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let charactersRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    let viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        
        title = "Marvel Super Heroes"
        accessibilityLabel = "Marvel Super Heroes"
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        charactersTableView.refreshControl = charactersRefreshControl
        
        charactersTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        charactersTableView.rowHeight = 60
        charactersTableView.dataSource = self
        charactersTableView.delegate = self

        viewModel.viewDidLoad()
    }
    
    fileprivate func showErrorFetchingCharactersAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching Marvel Characters\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    @objc fileprivate func pullToRefresh(sender: UIRefreshControl) {
        viewModel.fetchCharactersAndReloadUI()
        sender.endRefreshing()
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = charactersTableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell,
              let cellViewModel = viewModel.viewModel(at: indexPath) else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
            
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        charactersTableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension CharactersViewController: CharactersViewModelViewDelegate {
    func charactersFetched() {
        charactersTableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func errorFetchingCharacters() {
        showErrorFetchingCharactersAlert()
        activityIndicator.stopAnimating()
    }
}


