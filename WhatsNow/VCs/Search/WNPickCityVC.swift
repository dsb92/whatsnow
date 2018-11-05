//
//  WNPickCityVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class WNPopularLocation {
    var city: String
    var state: String
    
    init(city: String, state: String) {
        self.city = city
        self.state = state
    }
}

protocol WNPickCityVCDelegate: class {
    func pickCityVcDidSelectCity(_ sender: WNPickCityVC, location: WNPopularLocation)
    func pickCityVcDidSelectCurrentLocation(_ sender: WNPickCityVC)
}

class WNPickCityVC: WNBaseVC {
    @IBOutlet weak var closeButton: WNCloseButton!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var useCurrentLocationButton: WNMyLocationButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var popularLocations: [WNPopularLocation] = [WNPopularLocation(city: "San Francisco", state: "California"),
                                              WNPopularLocation(city: "New York", state: "New York"),
                                              WNPopularLocation(city: "Los Angeles", state: "California") ,
                                              WNPopularLocation(city: "London", state: "United Kingdom"),
                                              WNPopularLocation(city: "Washington", state: "District of Columbia"),
                                              WNPopularLocation(city: "Atlanta", state: "Georgia"),
                                              WNPopularLocation(city: "Chicago", state: "Illinois"),
                                              WNPopularLocation(city: "Boston", state: "Massachusetts"),
                                              WNPopularLocation(city: "Philadelphia", state: "Pennsylvania"),
                                              WNPopularLocation(city: "Miami", state: "Florida")] {
        didSet {
            UIView.transition(with: self.tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                //Do the data reload here
                self.tableView.reloadData()
            }, completion: nil)
        }
    }
    
    private let CELL_IDENTIFIER: String = "popularLocationCellId"
    private var lastIndexPath: IndexPath?
    private var localSearchRequest: MKLocalSearch?
    
    var delegate: WNPickCityVCDelegate?
    
    init(delegate: WNPickCityVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.whereTextField.attributedPlaceholder = NSAttributedString(string: "pick_location_where_placeholder".localized, attributes: [NSAttributedStringKey.font : WNFormatUtil.regularFont(ofSize: 27), NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        self.whereTextField.font = WNFormatUtil.semiBoldFont(ofSize: 27)
        self.whereTextField.textColor = UIColor.black
        self.whereTextField.autocapitalizationType = .sentences
        self.whereTextField.clearButtonMode = .whileEditing
        self.whereTextField.returnKeyType = .search
        self.whereTextField.delegate = self
        
        self.closeButton.tintColor = UIColor.black
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
    }
    
    private func search(location: String) {
        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = location
        
        self.localSearchRequest?.cancel()
        self.localSearchRequest = MKLocalSearch(request: request)
        
        self.localSearchRequest?.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.popularLocations.removeAll()
            
            for mapItem: MKMapItem in response.mapItems {
                let placemark: MKPlacemark = mapItem.placemark
                
                if let address: CNPostalAddress = placemark.postalAddress {
                    
                    if self.popularLocations.contains(where: { (location) -> Bool in
                        location.city == address.city
                    }) == false {
                        let location: WNPopularLocation = WNPopularLocation(city: address.city, state: address.state)
                        self.popularLocations.append(location)
                    }
                }
            }
        }
    }
    
    @IBAction func didTapUseCurrentLocation(_ sender: Any) {
        self.delegate?.pickCityVcDidSelectCurrentLocation(self)
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func whereTextFieldEditingChanged(_ sender: UITextField) {
        guard let searchText: String = sender.text, !searchText.isEmpty else { return }
        self.search(location: searchText)
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate
extension WNPickCityVC: UITableViewDataSource, UITableViewDelegate {
    private func indexPath(for location: WNPopularLocation) -> IndexPath? {
        for (i, l) in self.popularLocations.enumerated() {
            if l.city == location.city {
                return IndexPath(row: i, section: 0)
            }
        }
        
        return nil
    }
    
    private func location(for indexPath: IndexPath) -> WNPopularLocation? {
        for (i, l) in self.popularLocations.enumerated() {
            if i == indexPath.row {
                return l
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularLocations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_IDENTIFIER)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.CELL_IDENTIFIER)
            cell?.accessoryType = self.lastIndexPath == indexPath ? .checkmark : .none
            cell?.textLabel?.font = WNFormatUtil.regularFont(ofSize: 14)
            cell?.textLabel?.textColor = .black
            cell?.detailTextLabel?.font = WNFormatUtil.regularFont(ofSize: 12)
            cell?.detailTextLabel?.textColor = .black
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let location: WNPopularLocation = self.location(for: indexPath) {
            cell.textLabel?.text = location.city
            cell.detailTextLabel?.text = location.state
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if let location: WNPopularLocation = self.location(for: indexPath) {
            self.delegate?.pickCityVcDidSelectCity(self, location: location)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

// MARK: - UITextFieldDelegate
extension WNPickCityVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text: String = textField.text {
            self.search(location: text)
        }
        
        return true
    }
}
