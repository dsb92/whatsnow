//
//  WNReadMoreVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 26/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNReadMoreVC: WNBaseVC {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    var event: WNEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.size.width, height: self.textView.bounds.size.height)
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.title = event?.name?.text
        
        guard let event: WNEvent = event else { return }
        
        self.textView.dataDetectorTypes = .all
        self.textView.isEditable = false
        self.textView.isScrollEnabled = false
        self.textView.textContainerInset = .zero
        self.textView.textContainer.lineFragmentPadding = 0
        self.textView.attributedText = event.descriptionField?.html?.htmlAttributedContent(withFont: UIFont.systemFont(ofSize: 16), andColor: .black)
        self.textView.textContainer.lineBreakMode = .byTruncatingTail
        self.textView.sizeToContent()
        self.textView.layoutIfNeeded()
    }
}
