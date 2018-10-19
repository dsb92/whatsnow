//
//  WNSearchEventsVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import Hero

class WNEventsVC: WNBaseVC {
    
    @IBOutlet weak var eventCollectionView: WNEventsCollectionView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceApplyFilterButton: WNGradientButton!
    @IBOutlet weak var distanceSliderValueView: WNGradientView!
    @IBOutlet weak var distanceSliderValueLabel: UILabel!
    
    @IBOutlet var filterViewTopConstraint: NSLayoutConstraint!
    
    private var FILTER_HEIGHT: CGFloat = 200
    
    private var defaultDistanceRadiusInKm: Float = 25
    private var showingFilter: Bool = false
    
    private var currentDistanceRadiusInKm: Float = 0
    
    var cityForCurrentEvents: String = String() {
        didSet {
            self.title = self.cityForCurrentEvents
        }
    }
    
    var requestMyLocation: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate.tabBarCon.delegate = self
        
        self.eventCollectionView.eventsCollectionViewDelegate = self
        self.eventCollectionView.eventsCollectionViewScrollViewDelegate = self
        self.eventCollectionView.delaysContentTouches = false
        
        if self.requestMyLocation {
            self.locCon.requestMyLocation()
            self.locCon.delegate = self
        }
    }    
    override func setupUI() {
        super.setupUI()
        
        self.distanceSliderValueView.setGradient(withColors: WNFormatUtil.themeGradient())
        self.distanceSliderValueView.layer.cornerRadius = self.distanceSliderValueView.bounds.size.height / 2
        self.distanceSliderValueView.clipsToBounds = true
        
        self.distanceSliderValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.distanceSliderValueLabel.textColor = UIColor.white
        
        self.distanceSlider.tintColor = WNFormatUtil.themeColorBlue()
        
        self.distanceApplyFilterButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.distanceApplyFilterButton.titleLabel?.textColor = UIColor.white
        self.distanceApplyFilterButton.setTitleColor(UIColor.white, for: .normal)
        self.distanceApplyFilterButton.titleLabel?.text = "filter_button_apply".localized
        self.distanceApplyFilterButton.setTitle("filter_button_apply".localized, for: .normal)
        self.distanceApplyFilterButton.setGradient(withColors: WNFormatUtil.themeGradient())
        
        self.setFilter(distanceRadiusInKm: self.defaultDistanceRadiusInKm)
        
        self.showFilter(false)
    }
    
    override func assignDelegates() {
        super.assignDelegates()
        
        self.dataCon.eventsDelegate = self
    }
    
    private func showFilter(_ show: Bool) {
        self.showingFilter = show
        
        if show {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter_black.png"), style: .plain, target: self, action: #selector(self.didTapCloseFilterButton))
            
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter_black.png"), style: .plain, target: self, action: #selector(self.didTapFilterButton))
        }
        
        self.view.layoutIfNeeded()
        
        self.layoutFilter()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func layoutFilter() {
        if let navigationBar: UINavigationBar = self.navigationController?.navigationBar {
            let height: CGFloat = UIApplication.shared.statusBarFrame.size.height + navigationBar.bounds.height
            self.filterViewTopConstraint.constant = self.showingFilter ? height : -FILTER_HEIGHT
        }
    }
    
    @objc func refreshData() {
        self.dataCon.searchEvents(fromAddress: self.cityForCurrentEvents)
    }
    
    private func setFilter(distanceRadiusInKm: Float) {
        self.distanceSliderValueLabel.text = "\(Int(distanceRadiusInKm)) km"
        self.distanceSlider.value = distanceRadiusInKm
    }
    
    @objc func didTapFilterButton() {
        WNHapticFeedBackUtil.itemSelected()
        
        self.showFilter(true)
    }
    
    @objc func didTapCloseFilterButton() {
        WNHapticFeedBackUtil.itemSelected()
        
        self.showFilter(false)
    }
    
    @IBAction func didTapApplyFilterButton(_ sender: UIButton) {
        WNHapticFeedBackUtil.itemSelected()
        
        self.showFilter(false)
        
        let distanceValue: Int = Int(self.distanceSlider.value)
        
        self.progressSpinner.startAnimating()
        self.dataCon.searchEvents(fromAddress: self.cityForCurrentEvents, andRadiusInKm: distanceValue)
    }
    
    @IBAction func distanceSliderDidChangeValue(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        if self.currentDistanceRadiusInKm != roundedValue {
            self.currentDistanceRadiusInKm = roundedValue
            WNHapticFeedBackUtil.itemSelected()
        }
        
        self.setFilter(distanceRadiusInKm: sender.value)
    }
}

// MARK: - WNLocationControllerDelegate
extension WNEventsVC: WNLocationControllerDelegate {
    func locationControllerDidChangeCity(_ sender: WNLocationController, city: String) {
        if city.lowercased() != self.cityForCurrentEvents.lowercased() {
            self.progressSpinner.startAnimating()
            self.dataCon.searchEvents(fromAddress: city)
            self.cityForCurrentEvents = city
        }
    }
}

// MARK: - WNDataControllerEventsDelegate
extension WNEventsVC: WNDataControllerEventsDelegate {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser) {
        self.progressSpinner.stopAnimating()
        
        guard let events: [WNEvent] = parser.events else { return }
        
        var eventsDictionary: [String: [WNEvent]] = [String: [WNEvent]]()
        var sortedKeys: [String] = [String]()
        
        for event in events {
            if let start = event.start {
                let eventDateString: String = WNFormatUtil.formatDate(start.utc ?? "")
                if var originalEvents_ = eventsDictionary[eventDateString] {
                    
                    let exists = originalEvents_.first { $0.id?.lowercased() == event.id?.lowercased() }
                    
                    if exists == nil {
                        originalEvents_.append(event)
                    }
                    
                    eventsDictionary[eventDateString] = originalEvents_
                } else {
                    eventsDictionary[eventDateString] = [event]
                }
                
                if !sortedKeys.contains(eventDateString) {
                    sortedKeys.append(eventDateString)
                }
            }
        }
        
        self.eventCollectionView.sortedKeys = sortedKeys
        self.eventCollectionView.eventsDic = eventsDictionary
    }
}

// MARK: - UITabBarControllerDelegate
extension WNEventsVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 0 {
            self.eventCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

// MARK: - WNEventsCollectionViewDelegate
extension WNEventsVC: WNEventsCollectionViewDelegate {
    func eventsCollectionViewDidFavoriteEvent(_ sender: WNEventsCollectionView, event: WNEvent, favorite: Bool) {
        
    }
    
    func eventsCollectionViewDidTapShareEvent(_ sender: WNEventsCollectionView, event: WNEvent) {
        self.presentShareController(withEvent: event)
    }
    
    func eventsCollectionViewDidSelectEvent(_ sender: WNEventsCollectionView, event: WNEvent) {
        self.presentEventDetail(withEvent: event)
    }
}

// MARK: - WNEventsCollectionViewScrollViewDelegate
extension WNEventsVC: WNEventsCollectionViewScrollViewDelegate {
    func eventsCollectionViewDidBeginDragging(_ sender: WNEventsCollectionView) {
        self.layoutFilter()
    }
    
    func eventsCollectionViewDidScroll(_ sender: WNEventsCollectionView) {
        self.layoutFilter()
    }
}
