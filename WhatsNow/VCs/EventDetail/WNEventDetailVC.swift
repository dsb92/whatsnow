//
//  WNEventDetailVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import Hero

class WNEventDetailVC: WNBaseVC, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var cardView: WNCardView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var practicalInfoView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var ticketIcon: UIImageView!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var addToCalendarButton: UIButton!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var ticketMasterLabel: UILabel!
    
    let closeButton: UIButton = UIButton(type: .custom)
    
    var event: WNEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHero()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupFrames()
    }
    
    private func setupHero() {
        guard let event: WNEvent = event else { return }
        
        let cardHeroId = "card\(event.id ?? "")"
        
        self.cardView.hero.id = cardHeroId
        self.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        
        self.scrollView.hero.modifiers = [.source(heroID: cardHeroId), .spring(stiffness: 250, damping: 25)]
        
        self.closeButton.hero.modifiers = [.fade, .useNoSnapshot]
        
        self.contentView.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 250, damping: 25)]
        
        self.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.view.backgroundColor = .clear
        
        self.view.addSubview(closeButton)
        
        // add a pan gesture recognizer for the interactive dismiss transition
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
        
        guard let event: WNEvent = event else { return }
        
        self.cardView.titleLabel.text = event.name?.text
        self.cardView.subtitleLabel.text = event.organizer?.name
        if let imageUrl: URL = URL(string: event.logo?.original?.url ?? "") {
            self.cardView.imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: .scaleDownLargeImages)
        }
        
        self.calendarIcon.image = #imageLiteral(resourceName: "icon_calender_black")
        self.locationIcon.image = #imageLiteral(resourceName: "icon_location_pin_black")
        self.ticketIcon.image = #imageLiteral(resourceName: "icon_ticket_black")
        
        self.startDateLabel.font = UIFont.systemFont(ofSize: 16)
        self.startDateLabel.textColor = UIColor.black
        self.startDateLabel.text = WNFormatUtil.formatDate(event.start?.utc ?? "")
        
        self.timeLabel.font = UIFont.systemFont(ofSize: 16)
        self.timeLabel.textColor = UIColor.lightGray
        self.timeLabel.text = WNFormatUtil.formatTime(event.start?.utc ?? "") + " - " + WNFormatUtil.formatTime(event.end?.utc ?? "")
        
        self.locationNameLabel.font = UIFont.systemFont(ofSize: 16)
        self.locationNameLabel.textColor = UIColor.black
        self.locationNameLabel.text = event.venue?.name
        
        self.locationAddressLabel.font = UIFont.systemFont(ofSize: 16)
        self.locationAddressLabel.textColor = UIColor.lightGray
        self.locationAddressLabel.text = event.venue?.address?.localizedAddressDisplay
        
        self.ticketLabel.font = UIFont.systemFont(ofSize: 16)
        self.ticketLabel.textColor = UIColor.black
        self.ticketLabel.text = "free".localized
        
        self.ticketMasterLabel.font = UIFont.systemFont(ofSize: 16)
        self.ticketMasterLabel.textColor = UIColor.lightGray
        self.ticketMasterLabel.text = "ticket_master_eventbrite".localized
        
        self.textView.dataDetectorTypes = .all
        self.textView.isEditable = false
        self.textView.isScrollEnabled = false
        self.textView.textContainerInset = .zero
        self.textView.textContainer.lineFragmentPadding = 0
        self.textView.attributedText = event.descriptionField?.html?.htmlAttributedContent(withFont: UIFont.systemFont(ofSize: 16), andColor: .black)
        self.textView.textContainer.maximumNumberOfLines = 10;
        self.textView.textContainer.lineBreakMode = .byTruncatingTail
        self.textView.sizeToContent()
        self.textView.layoutIfNeeded()
        
        self.readMoreButton.setTitle("read_more_button".localized, for: .normal)
        self.readMoreButton.titleLabel?.text = "read_more_button"
        
        self.scrollView.backgroundColor = .white
        self.scrollView.clipsToBounds = true
        self.scrollView.bounces = true
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        self.scrollView.isScrollEnabled = true
        self.scrollView.delegate = self
        
        self.closeButton.frame = CGRect(x: self.view.bounds.width - 44, y: 20, width: 30, height: 30)
        self.closeButton.setImage(#imageLiteral(resourceName: "ic_close.png").withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeButton.imageView?.tintColor = UIColor.white.withAlphaComponent(0.8)
        self.closeButton.addTarget(self, action: #selector(self.didTapCloseButton(_:)), for: .touchUpInside)
        self.closeButton.layer.cornerRadius = closeButton.bounds.size.width/2.0;
        self.closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.closeButton.hero.id = "back button"
        
        self.setupFrames()
    }
    
    private func setupFrames() {
        let bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        self.visualEffectView.frame  = bounds
        self.scrollView.frame  = bounds
        
        var outerYOffset: CGFloat = 0
        var contentYOffset: CGFloat = 0
        
        self.cardView.frame = CGRect(x: 0, y: outerYOffset, width: bounds.width, height: bounds.width)
        
        outerYOffset += self.cardView.bounds.size.height
        
        // Content here
        contentYOffset += 20
        
        // Practical info
        self.practicalInfoView.frame = CGRect(x: 0, y: contentYOffset, width: self.contentView.bounds.size.width, height: 240)
        
        contentYOffset += self.practicalInfoView.bounds.size.height
        
        // Description
        self.textView.frame = CGRect(x: 20, y: contentYOffset, width: bounds.width - 40, height: self.textView.bounds.size.height)
        
        contentYOffset += self.textView.bounds.size.height
        
        let textViewTruncated: Bool = self.textView.isTruncated()
        self.readMoreButton.frame = CGRect(x: 20, y: contentYOffset, width: 100, height: textViewTruncated ? 50 : 0)
        self.readMoreButton.isHidden = !textViewTruncated
        
        contentYOffset += self.readMoreButton.bounds.size.height
    
        self.contentView.frame = CGRect(x: 0, y: outerYOffset, width: bounds.width, height: contentYOffset)
        
        self.scrollView.contentSize = CGSize(width: bounds.width, height: outerYOffset + contentYOffset)
        
        self.closeButton.layer.cornerRadius = self.closeButton.bounds.size.width/2.0;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions
    @objc func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapReadMoreButton(_ sender: UIButton) {
        let readMoreVc: WNReadMoreVC = WNReadMoreVC()
        readMoreVc.event = self.event
        
        self.navigationController?.pushViewController(readMoreVc, animated: true)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: self.view)
        
        if translation.y > 0 && self.scrollView.contentOffset.y <= 0 {
            switch gr.state {
            case .began:
                print("began")
                dismiss(animated: true, completion: nil)
            case .changed:
                print("changed")
                Hero.shared.update(translation.y / view.bounds.height)
            default:
                let velocity = gr.velocity(in: view)
                print("velo: \(velocity.y)")
                print("trans: \(translation.y)")
                print("bounds: \(view.bounds.height)")
                print("total: \(translation.y + velocity.y)")
                print("diff: \((translation.y + velocity.y) / view.bounds.height)")
                
                if ((translation.y + velocity.y) / view.bounds.height) > 0 {
                    print("finished")
                    Hero.shared.finish()
                } else {
                    print("cancel")
                    Hero.shared.cancel()
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offset: CGFloat = scrollView.contentOffset.y
            
            print("scrollView: \(offset)")
            
            scrollView.bounces = (scrollView.contentOffset.y > 0);
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
