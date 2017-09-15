
//  SearchItem
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation
import UIKit

class SearchItem: UICollectionViewCell {
    // MARK: - Local Properties 💻
    private var _categoryLabel: UILabel!
    private var _nameLabel: UILabel!
    private var _checkinsLabel: UILabel!
    
    // MARK: - Global Properties 🌎
    var categoryLabel: UILabel {
        get {
            return _categoryLabel
        } set {
            _categoryLabel = _categoryLabel ?? newValue
            contentView.addSubview(_categoryLabel)
        }
    }
    var nameLabel: UILabel {
        get {
            return _nameLabel
        } set {
            _nameLabel = _nameLabel ?? newValue
            contentView.addSubview(_nameLabel)
        }
    }
    var checkinsLabel: UILabel {
        get {
            return _checkinsLabel
        } set {
            _checkinsLabel = _checkinsLabel ?? newValue
            contentView.addSubview(_checkinsLabel)
        }
    }
    
    // MARK: - UICollectionViewCell Methods 👑
    override func prepareForReuse() {
        super.prepareForReuse()
        _categoryLabel?.removeFromSuperview()
        _nameLabel.removeFromSuperview()
        _checkinsLabel.removeFromSuperview()
        _categoryLabel = nil
        _nameLabel = nil
        _checkinsLabel = nil
    }
}

