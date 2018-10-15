//
//  WNEventDetailVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import MapKit
import Hero

enum WNMapsType {
    case apple
    case google
}

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
    
    @IBOutlet weak var locationSnapShotLabel: UILabel!
    @IBOutlet weak var locationSnapShotNameLabel: UILabel!
    @IBOutlet weak var locationSnapShotImageView: UIImageView!
    
    @IBOutlet weak var eventsLikeThisLabel: UILabel!
    @IBOutlet weak var eventsLikeThisCollectionView: WNEventsLikeThisCollectionView!
    
    let closeButton: UIButton = UIButton(type: .custom)
    
    var seperatorOne: UIView = UIView()
    var seperatorTwo: UIView = UIView()
    var seperatorThree: UIView = UIView()
    lazy var seperators: [UIView] = [UIView]()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var event: WNEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHero()
        
        guard let event: WNEvent = self.event else { return }
        
        self.dataCon.searchEvents(fromAddress: event.venue?.address?.city ?? "", andCategoryId: event.categoryId ?? "")
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
        guard let event: WNEvent = self.event else { return }
        
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
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .clear
        
        self.view.addSubview(self.closeButton)
        
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
        
        self.locationSnapShotLabel.text = "location_label".localized
        self.locationSnapShotLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.locationSnapShotLabel.textColor = .black
        
        self.locationSnapShotNameLabel.text = event.venue?.name
        self.locationSnapShotNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.locationSnapShotNameLabel.textColor = .lightGray
        
        self.locationSnapShotImageView.contentMode = .scaleAspectFit
        self.locationSnapShotImageView.isUserInteractionEnabled = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapLocationSnapShot(_:)))
        tapGesture.cancelsTouchesInView = false
        self.locationSnapShotImageView.addGestureRecognizer(tapGesture)
        
        self.eventsLikeThisLabel.text = "events_like_this".localized
        self.eventsLikeThisLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.eventsLikeThisLabel.textColor = .black
        
        self.eventsLikeThisCollectionView.eventsCollectionViewDelegate = self
        self.eventsLikeThisCollectionView.delaysContentTouches = false
        self.eventsLikeThisCollectionView.clipsToBounds = false
        
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
        self.closeButton.layer.cornerRadius = closeButton.bounds.size.width/2.0
        self.closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.closeButton.hero.id = "back button"
        
        self.seperators.append(self.seperatorOne)
        self.seperators.append(self.seperatorTwo)
        self.seperators.append(self.seperatorThree)
        
        self.contentView.addSubview(self.seperatorOne)
        self.contentView.addSubview(self.seperatorTwo)
        self.contentView.addSubview(self.seperatorThree)
        
        self.seperators.forEach {
            $0.backgroundColor = UIColor.lightGray
        }
        
        if let lat: Double = Double(event.venue?.latitude ?? ""), let long: Double = Double(event.venue?.longitude ?? "") {
            if let cachedImage: UIImage = self.cachedImage(for: self.cachedLocationSnapShotKey(from: lat, longitude: long)) {
                self.locationSnapShotImageView.image = cachedImage
            } else {
                self.createLocationSnapShot(from: lat, longitude: long)
            }
        }
        
        self.setupFrames()
    }
    
    private func setupFrames() {
        let bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        let contentMarginX: CGFloat = 20
        let contentWidth: CGFloat = bounds.width - contentMarginX*2
        
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

        // Seperator one
        self.seperatorOne.frame = CGRect(x: contentMarginX, y: contentYOffset + contentMarginX, width: contentWidth, height: 1)
        
        contentYOffset += self.seperatorOne.bounds.size.height + contentMarginX*2
        
        // Description
        self.textView.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: self.textView.bounds.size.height)
        
        contentYOffset += self.textView.bounds.size.height
        
        // Read more
        let textViewTruncated: Bool = self.textView.isTruncated()
        self.readMoreButton.frame = CGRect(x: contentMarginX, y: contentYOffset, width: 100, height: textViewTruncated ? 50 : 0)
        self.readMoreButton.isHidden = !textViewTruncated
        
        contentYOffset += self.readMoreButton.bounds.size.height
    
        // Seperator two
        self.seperatorTwo.frame = CGRect(x: contentMarginX, y: contentYOffset + contentMarginX, width: contentWidth, height: 1)
        
        contentYOffset += self.seperatorTwo.bounds.size.height + contentMarginX*2
        
        // Location snapshot label
        self.locationSnapShotLabel.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: 30)
        
        contentYOffset += self.locationSnapShotLabel.bounds.size.height
        
        // Location snapshot name label
        self.locationSnapShotNameLabel.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: 30)
        
        contentYOffset += self.locationSnapShotNameLabel.bounds.size.height
        
        // Location snapshot
        self.locationSnapShotImageView.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: 300)
        
        contentYOffset += self.locationSnapShotImageView.bounds.size.height
        
        // Seperator three
        self.seperatorThree.frame = CGRect(x: contentMarginX, y: contentYOffset + contentMarginX, width: contentWidth, height: 1)
        
        contentYOffset += self.seperatorThree.bounds.size.height + contentMarginX*2
        
        self.eventsLikeThisLabel.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: 30)
        
        contentYOffset += self.eventsLikeThisLabel.bounds.size.height
        
        self.eventsLikeThisCollectionView.frame = CGRect(x: contentMarginX, y: contentYOffset, width: contentWidth, height: contentWidth + 80)
        
        contentYOffset += self.eventsLikeThisCollectionView.bounds.size.height
        
        self.contentView.frame = CGRect(x: 0, y: outerYOffset, width: bounds.width, height: contentYOffset)
        
        self.scrollView.contentSize = CGSize(width: bounds.width, height: outerYOffset + contentYOffset)
        
        self.closeButton.layer.cornerRadius = self.closeButton.bounds.size.width/2.0;
    }
    
    private func createLocationSnapShot(from latitude: Double, longitude: Double) {
        let mapSnapshotOptions = MKMapSnapshotOptions()
        
        // Set the region of the map that is rendered.
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        mapSnapshotOptions.region = region
        
        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale
        
        // Set the size of the image output.
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)
        
        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        
        snapShotter.start { (snapshot:MKMapSnapshot?, error:Error?) in
            let image = snapshot?.image
            
            // Cache image if possible
            if let image_: UIImage = image {
                self.cacheImage(image: image_, key: self.cachedLocationSnapShotKey(from: latitude, longitude: longitude))
            }
            
            // Display snapshot
            self.locationSnapShotImageView.image = image
        }
    }
    
    override func assignDelegates() {
        super.assignDelegates()
        
        self.dataCon.eventsDelegate = self
    }
    
    private func cachedLocationSnapShotKey(from latitude: Double, longitude: Double) -> String {
        return "Cached_location-\(latitude)V\(longitude)"
    }
    
    private func cacheImage(image: UIImage, key: String) {
        self.imageCache.setObject(image, forKey: key as NSString)
    }
    
    private func cachedImage(for key: String) -> UIImage? {
        return self.imageCache.object(forKey: key as NSString)
    }
    
    private func openInMaps(ofType type: WNMapsType, withName name: String, latitude: Double, longitude: Double) {
        if type == .apple {
            let latitude: CLLocationDegrees = latitude
            let longitude: CLLocationDegrees = longitude
            
            let regionDistance:CLLocationDistance = 1000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            mapItem.openInMaps(launchOptions: options)
        } else {
            if let urlScheme: URL = URL(string:"comgooglemaps://"), UIApplication.shared.canOpenURL(urlScheme) {
                if let locationUrl: URL = URL(string:
                    "comgooglemaps://?q=\(name.encodeToUrl)&center=\(latitude),\(longitude)&zoom=14&views=traffic") {
                    UIApplication.shared.open(locationUrl, options: [:], completionHandler: nil)
                }
            } else {
                print("Can't use comgooglemaps://");
                let alertCon: UIAlertController = UIAlertController(title: "error".localized, message: "google_maps_app_not_installed".localized, preferredStyle: .alert)
                let okAction: UIAlertAction = UIAlertAction(title: "ok".localized, style: .default) { (_) in
                    
                }
                alertCon.addAction(okAction)
                
                self.present(alertCon, animated: true, completion: nil)
            }
        }
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
    
    @IBAction func didTapByOrganizerButton(_ sender: UIButton) {
        let organizerVc: WNOrganizerVC = WNOrganizerVC()
        organizerVc.event = self.event
        
        self.navigationController?.pushViewController(organizerVc, animated: true)
    }
    
    @objc func didTapLocationSnapShot(_ sender: UITapGestureRecognizer) {
        if let event: WNEvent = self.event, let name: String = event.venue?.name, let latitude: Double = Double(event.venue?.latitude ?? ""), let longitude: Double = Double(event.venue?.longitude ?? "") {
            let alertSheet: UIAlertController = UIAlertController(title: "open_in_maps".localized, message: nil, preferredStyle: .actionSheet)
            let appleMapsAction: UIAlertAction = UIAlertAction(title: "Apple Maps", style: .default) { (_) in
                
                self.openInMaps(ofType: .apple, withName: name, latitude: latitude, longitude: longitude)
            }
            let googleMapsAction: UIAlertAction = UIAlertAction(title: "Google Maps", style: .default) { (_) in
                self.openInMaps(ofType: .google, withName: name, latitude: latitude, longitude: longitude)
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
            
            alertSheet.addAction(appleMapsAction)
            alertSheet.addAction(googleMapsAction)
            alertSheet.addAction(cancelAction)
            
            self.present(alertSheet, animated: true, completion: nil)
        }
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

extension WNEventDetailVC: WNEventsCollectionViewDelegate {
    func eventsCollectionViewDidSelectEvent(_ sender: WNEventsCollectionView, event: WNEvent) {
        self.presentEventDetail(withEvent: event)
    }
}

extension WNEventDetailVC: WNDataControllerEventsDelegate {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser) {
        guard let events: [WNEvent] = parser.events else { return }
        
        self.eventsLikeThisCollectionView.events = events.filter { $0.id != self.event?.id }
    }
}
