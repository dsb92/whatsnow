//
//  WNPickCityVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNPickCityVC: WNBaseVC {
    @IBOutlet weak var closeButton: WNCloseButton!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var useCurrentLocationButton: WNMyLocationButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.whereTextField.delegate = self
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapUseCurrentLocation(_ sender: Any) {
        
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate
extension WNPickCityVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITextFieldDelegate
extension WNPickCityVC: UITextFieldDelegate {
    
}
