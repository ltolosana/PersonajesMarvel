//
//  CharacterDetailViewController.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 24/1/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    let viewModel: CharacterDetailViewModel
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterComicsLabel: UILabel!
    @IBOutlet weak var characterStoriesLabel: UILabel!
    @IBOutlet weak var characterEventsLabel: UILabel!
    @IBOutlet weak var characterSeriesLabel: UILabel!
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!
    
    let detailRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailActivityIndicator.isHidden = false
        detailActivityIndicator.startAnimating()
        detailScrollView.refreshControl = detailRefreshControl
        viewModel.viewDidLoad()
        
    }

    fileprivate func updateUI() {
        characterDescriptionLabel.text = viewModel.characterDescription
        characterDescriptionLabel.accessibilityLabel = viewModel.characterDescription
        characterImageView.image = viewModel.characterImage
        characterImageView.alpha = 1
        characterComicsLabel.text = viewModel.characterComics
        characterComicsLabel.accessibilityLabel = viewModel.characterComics
        characterStoriesLabel.text = viewModel.characterStories
        characterStoriesLabel.accessibilityLabel = viewModel.characterStories
        characterEventsLabel.text = viewModel.characterEvents
        characterEventsLabel.accessibilityLabel = viewModel.characterEvents
        characterSeriesLabel.text = viewModel.characterSeries
        characterSeriesLabel.accessibilityLabel = viewModel.characterSeries
    }
    
    fileprivate func showErrorFetchingCharacterDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching Marvel Character Detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    @objc fileprivate func pullToRefresh(sender: UIRefreshControl) {
        viewModel.fetchCharacterAndReloadUI()
        sender.endRefreshing()
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelViewDelegate {
    func characterDetailFetched() {
        updateUI()
        detailActivityIndicator.stopAnimating()
    }
    
    func errorFetchingCharacterDetail() {
        showErrorFetchingCharacterDetailAlert()
        detailActivityIndicator.stopAnimating()
    }
}
