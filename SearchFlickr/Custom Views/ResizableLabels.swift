//
//  ResizableLabels.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation
import UIKit

class ResizableLabels: UILabel {
    init(frame: CGRect, font: UIFont) {
        super.init(frame: frame)
        setupUI(withFont: font)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI(withFont: UIFont.systemFont(ofSize: 16))
    }
    
    private func setupUI(withFont font: UIFont) {
        numberOfLines = 0
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        self.font = font
        textAlignment = .center
    }
}
