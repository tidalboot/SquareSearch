
//  SearchItem
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation
import UIKit

class SearchItem: UICollectionViewCell {
    // MARK: - Local Properties 💻
    private var _categoryLabel: UILabel!
    private var _nameLabel: UILabel!
    private var _checkinsLabel: UILabel!
    private var _imageView: UIImageView!
    
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
    var imageView: UIImageView {
        get {
            return _imageView
        } set {
            _imageView = _imageView ?? newValue
            _imageView.contentMode = .scaleAspectFill
            _imageView.clipsToBounds = true
            
            //Here we add a gradient overlay effect to the image so that the title will always be readable, irrelevant of the image colour
            let backgroundGradient = CAGradientLayer()
            backgroundGradient.frame = _imageView.frame
            backgroundGradient.locations = [0.0, 0.75]
            let fadedLightGray = UIColor.init(colorLiteralRed: 177.0 / 255.0, green: 177.0 / 255.0, blue: 177.0 / 255.0, alpha: 0.05)
            let fadedBlack = UIColor.init(colorLiteralRed: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.75)
            backgroundGradient.colors = [fadedLightGray.cgColor, fadedBlack.cgColor]
            _imageView.layer.insertSublayer(backgroundGradient, at: 1)
            
            contentView.addSubview(_imageView)
        }
    }
    
    // MARK: - UICollectionViewCell Methods 👑
    override func prepareForReuse() {
        super.prepareForReuse()
        _categoryLabel?.removeFromSuperview()
        _nameLabel.removeFromSuperview()
        _checkinsLabel.removeFromSuperview()
        _imageView?.removeFromSuperview()
        _categoryLabel = nil
        _nameLabel = nil
        _checkinsLabel = nil
        _imageView = nil
    }
}

