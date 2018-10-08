//
//  WNEventsByOrganizerCollectionVIew.swift
//  WhatsNow
//
//  Created by David Buhauer on 08/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

protocol WNEventsByOrganizerCollectionViewDelegate: class {
    func eventsCollectionViewDidSelectEvent(_ sender: WNEventsByOrganizerCollectionView, event: WNEvent)
}

class WNEventsByOrganizerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var events: [WNEvent] = [WNEvent]() {
        didSet {
            self.isHidden = self.events.isEmpty ? true : false
            self.reloadData()
        }
    }

    let EVENT_CELL_IDENTIFIER: String = String(describing: WNEventCollectionViewCell.self)

    weak var eventsCollectionViewDelegate: WNEventsByOrganizerCollectionViewDelegate?
    
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
    
    private func registerCells() {
        self.register(UINib(nibName: self.EVENT_CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: self.EVENT_CELL_IDENTIFIER)
    }
    
    private func event(forIndexPath indexPath: IndexPath) -> WNEvent? {
        let event: WNEvent = self.events[indexPath.item]
        
        return event
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionSize: CGSize = collectionView.bounds.size
        
        return CGSize(width: collectionSize.width - 40, height: collectionSize.width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: WNEventCollectionViewCell = self.dequeueReusableCell(withReuseIdentifier: self.EVENT_CELL_IDENTIFIER, for: indexPath) as? WNEventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let event: WNEvent = self.event(forIndexPath: indexPath) else { return cell }
        
        cell.cardView.cardView.titleLabel.text = event.name?.text
        cell.cardView.cardView.subtitleLabel.text = event.organizer?.name
        
        if let imageUrl: URL = URL(string: event.logo?.original?.url ?? "") {
            cell.cardView.cardView.imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: .scaleDownLargeImages)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let event: WNEvent = self.event(forIndexPath: indexPath) else { return }
        
        if let cell: WNEventCollectionViewCell = self.cellForItem(at: indexPath) as? WNEventCollectionViewCell {
            let cardHeroId = "card\(event.id ?? "")"
            cell.cardView.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
            cell.cardView.cardView.hero.id = cardHeroId
        }
        
        self.eventsCollectionViewDelegate?.eventsCollectionViewDidSelectEvent(self, event: event)
    }
}
