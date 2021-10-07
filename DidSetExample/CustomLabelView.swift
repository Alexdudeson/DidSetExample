//
//  CustomLabelView.swift
//  DidSetExample
//
//  Created by Alexey Yarov on 07/10/2021.
//  Copyright © 2021 Alexey Yarov. All rights reserved.
//

import UIKit

class CustomLabelView: UIView {

   
    var score = "0" {
        didSet {
            label.text = score
        }
    }
    
    private let label = UILabel()
    
    override init (frame: CGRect) {
        super.init (frame:frame)
        addSubview(label)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32)
        label.text = score
        label.backgroundColor = .systemTeal
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
