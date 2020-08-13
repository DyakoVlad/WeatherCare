//
//  RoundedButton.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 13.08.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

public final class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
}
