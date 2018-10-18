//
//  WNEventsByOrganizerCollectionVIew.swift
//  WhatsNow
//
//  Created by David Buhauer on 08/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNEventsLikeThisCollectionView: WNEventsCollectionView {

    var events: [WNEvent] = [WNEvent]() {
        didSet {
            self.isHidden = self.events.isEmpty ? true : false
            self.reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    private func setup() {
        self.setupAndRegisterCells()
        
        self.delaysContentTouches = false
        
        if let layout: UICollectionViewFlowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setupAndRegisterCells() {
        self.registerCells()
        self.delegate = self
        self.dataSource = self
    }
    
    override func registerCells() {
        self.register(UINib(nibName: self.EVENT_CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: self.EVENT_CELL_IDENTIFIER)
    }
    
    override func event(forIndexPath indexPath: IndexPath) -> WNEvent? {
        let event: WNEvent = self.events[indexPath.item]
        
        return event
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
