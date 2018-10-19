//
//  WNEventCardView.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import SDWebImage

protocol WNCardViewDelegate: class {
    func cardViewDidTapFavoriteButton(_ sender: WNCardView, favorite: Bool)
    func cardViewDidTapShareButton(_ sender: WNCardView)
    func cardViewDidTapCloseButton(_ sender: WNCardView)
}

class WNCardView: UIView {
    let titleContainerView = UIView()
    let favButton = UIButton(type: .custom)
    let shareButton = UIButton(type: .custom)
    let closeButton: UIButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    
    private let defaultDuration: Double = 2.0
    private let defaultDamping: CGFloat = 0.20
    private let defaultVelocity: CGFloat = 6.0
    private let defaultButtonSpacing: CGFloat = 20
    
    var indexPath: IndexPath?
    
    weak var delegate: WNCardViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    func commonInit() {
        clipsToBounds = true
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 42, weight: .semibold)
        self.titleLabel.clipsToBounds = false
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        self.titleLabel.numberOfLines = 2
        self.titleLabel.lineBreakMode = .byTruncatingTail
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.sizeToFit()
        
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.subtitleLabel.clipsToBounds = false
        self.subtitleLabel.numberOfLines = 1
        self.subtitleLabel.lineBreakMode = .byTruncatingTail
        self.subtitleLabel.textColor = UIColor.gray
        self.subtitleLabel.sizeToFit()
        
        self.favButton.setImage(UIImage(named: "icon_heart_filled_black.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.favButton.addTarget(self, action: #selector(self.didTapFavoriteButton), for: .touchUpInside)
        self.favButton.imageView?.tintColor = UIColor.lightGray
        WNFormatUtil.formatActionButton(self.favButton)
        
        self.shareButton.setImage(UIImage(named: "icon_share_black.png"), for: .normal)
        self.shareButton.addTarget(self, action: #selector(self.didTapShareButton), for: .touchUpInside)
        WNFormatUtil.formatActionButton(self.shareButton)
        
        self.closeButton.setImage(#imageLiteral(resourceName: "ic_close.png").withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeButton.imageView?.tintColor = UIColor.white.withAlphaComponent(0.8)
        self.closeButton.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        self.closeButton.layer.cornerRadius = closeButton.bounds.size.width/2.0
        self.closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.imageView.contentMode = .scaleAspectFill
        
        self.titleContainerView.backgroundColor = UIColor.white
        
        self.titleContainerView.addSubview(self.titleLabel)
        self.titleContainerView.addSubview(self.subtitleLabel)
        
        self.addSubview(self.imageView)
        self.addSubview(self.titleContainerView)
        self.addSubview(self.favButton)
        self.addSubview(self.shareButton)
        self.addSubview(self.closeButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.favButton.layer.cornerRadius = self.favButton.bounds.size.width / 2
        self.shareButton.layer.cornerRadius = self.shareButton.bounds.size.width / 2
        self.closeButton.layer.cornerRadius = self.closeButton.bounds.size.width / 2
        
        let titleContainerWidth: CGFloat = self.titleContainerView.bounds.size.width - 40
        let titleTopMargin: CGFloat = 15
        let titleBottomMargin: CGFloat = 15
        
        var titleContentYOffset: CGFloat = titleTopMargin
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - self.titleContainerView.bounds.size.height)
        
        self.subtitleLabel.frame = CGRect(x: 20, y: titleContentYOffset, width: titleContainerWidth, height: 30)
        
        titleContentYOffset += self.subtitleLabel.bounds.size.height
        
        self.titleLabel.frame = CGRect(x: 20, y: titleContentYOffset , width: titleContainerWidth, height: self.titleLabel.intrinsicContentSize.height)
        
        titleContentYOffset += self.titleLabel.bounds.size.height
        
        titleContentYOffset += titleBottomMargin
        
        self.titleContainerView.frame = CGRect(x: 0, y: bounds.size.height - titleContentYOffset, width: bounds.size.width, height: titleContentYOffset)
        
        self.favButton.frame = CGRect(x: bounds.size.width - 70, y: bounds.size.height - self.titleContainerView.bounds.size.height - 25, width: 50, height: 50)
        self.shareButton.frame = CGRect(x: self.favButton.frame.origin.x - self.favButton.bounds.size.width - self.defaultButtonSpacing, y: bounds.size.height - self.titleContainerView.bounds.size.height - 25, width: 50, height: 50)
        
        self.closeButton.frame = CGRect(x: self.bounds.width - 44, y: 20, width: 30, height: 30)
    }
    
    private func animateButton(_ button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: self.defaultDuration,
                       delay: 0,
                       usingSpringWithDamping: self.defaultDamping,
                       initialSpringVelocity: self.defaultVelocity,
                       options: .allowUserInteraction,
                       animations: {
                        button.transform = .identity
        },
                       completion: { finished in
                        
        }
        )
    }
    
    private func toggleButton(_ button: UIButton) {
        WNHapticFeedBackUtil.itemSelected()
        self.favButton.isSelected = !self.favButton.isSelected
    }
    
    @objc func didTapFavoriteButton() {
        self.toggleButton(self.favButton)
        
        self.animateButton(self.favButton)
        
        if self.favButton.isSelected {
            self.favButton.imageView?.tintColor = UIColor.red
        } else {
            self.favButton.imageView?.tintColor = UIColor.lightGray
        }
        
        self.delegate?.cardViewDidTapFavoriteButton(self, favorite: self.favButton.isSelected)
    }
    
    @objc func didTapShareButton() {
        self.toggleButton(self.shareButton)
        
        self.animateButton(self.shareButton)
        
        self.delegate?.cardViewDidTapShareButton(self)
    }
    
    @objc func didTapCloseButton() {
        self.delegate?.cardViewDidTapCloseButton(self)
    }
}
