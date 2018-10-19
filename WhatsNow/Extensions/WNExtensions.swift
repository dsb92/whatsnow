//
//  WNImageExtension.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

extension UITabBarItem {
    func tabBarItemShowingOnlyImage() {
        // offset to center
        let offset: CGFloat = 6
        self.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        // displace to hide
        self.titlePositionAdjustment = UIOffset(horizontal:0,vertical:30000)
    }
}

extension Date {
    func dateWithoutTimeString(dateFormat: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = dateFormat
        return dateFormatter.string(from: self)
    }
}

extension UIImage {
    func resizeImage( newHeight: CGFloat) -> UIImage? {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    func htmlAttributedContent(withFont font: UIFont, andColor color: UIColor) -> NSAttributedString? {
        var fRed: CGFloat = 0.0, fGreen: CGFloat = 0.0, fBlue: CGFloat = 0.0, fAlpha: CGFloat = 0.0
        color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        let iRed: Int = Int((fRed * 255))
        let iGreen: Int = Int((fGreen * 255))
        let iBlue: Int = Int((fBlue * 255))
        let iAlpha: Int = Int((fAlpha * 255))
        
        let text: String = String(format: "<style>body{color: rgba(%d, %d, %d, %d); font-family: '%@'; font-size: %fpx;}</style>%@", iRed, iGreen, iBlue, iAlpha, font.familyName, font.pointSize, self)
        
        return text.htmlToAttributedString
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var encodeToUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:&=@+$,/?%#[] ").inverted) ?? self
    }
}

extension UITextView {
    func sizeToContent() {
        let fixedWidth = self.frame.size.width
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
    
    func isTruncated() -> Bool {
        let layoutManager = self.layoutManager
        let textStorage = layoutManager.textStorage
        let charIndex = (textStorage?.length ?? 1) - 1
        if charIndex > 0 {
            let glyphIndex = layoutManager.glyphIndexForCharacter(at: charIndex)
            let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndex, effectiveRange: nil)
            var glyphLoc = layoutManager.location(forGlyphAt: glyphIndex)
            glyphLoc.x += lineRect.minX
            glyphLoc.y += lineRect.minY
            if glyphLoc.x >= self.bounds.width ||
                glyphLoc.y >= self.bounds.height {
                return true
            }
        }
        
        return false
    }
}
