//
//  SquareView.swift
//  slumberChallenge
//
//  Created by Diego Henrick on 02/10/24.
//
import UIKit
import SnapKit

class SquareView: UIView {
    
    public let label = UILabel()
    
    init(color: UIColor, text: String, textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle) {
        super.init(frame: .zero)
        setupView(color: color, text: text, textAlignment: textAlignment, textStyle: textStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(color: UIColor, text: String, textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle) {
        self.backgroundColor = color
        
        label.text = text
        label.textColor = .black
        label.textAlignment = textAlignment
        label.font = UIFontMetrics.default.scaledFont(for: UIFont.preferredFont(forTextStyle: textStyle))
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
