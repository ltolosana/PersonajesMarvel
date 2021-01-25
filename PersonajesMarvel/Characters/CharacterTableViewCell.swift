//
//  CharacterTableViewCell.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 16/1/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterThumbnailImageView: UIImageView!
    
    var viewModel: CharacterCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self

            characterNameLabel?.text = viewModel.characterName
            characterNameLabel?.accessibilityLabel = viewModel.characterName
            characterThumbnailImageView?.image = viewModel.characterImage
            characterThumbnailImageView.alpha = 1
        }
    }
}

extension CharacterTableViewCell: CharacterCellViewModelViewDelegate {
    func characterImageFetched() {
        characterThumbnailImageView?.image = viewModel?.characterImage
        characterThumbnailImageView.alpha = 1
        setNeedsLayout()
    }
}
