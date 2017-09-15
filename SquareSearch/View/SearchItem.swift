
//  SearchItem
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation
import UIKit

class SearchItem: UICollectionViewCell {
    // MARK: - Local Properties 💻
    private var _detailsLabel: UILabel!
    private var _imageView: UIImageView!
    
    // MARK: - Global Properties 🌎
    var detailsLabel: UILabel {
        get {
            return _detailsLabel
        } set {
            _detailsLabel = _detailsLabel ?? newValue
            contentView.addSubview(_detailsLabel)
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
        _detailsLabel?.removeFromSuperview()
        _imageView?.removeFromSuperview()
        
        _detailsLabel = nil
        _imageView = nil
    }
}

