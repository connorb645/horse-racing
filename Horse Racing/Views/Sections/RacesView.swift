//
//  RacesView.swift
//  Horse Racing
//
//  Created on 03/08/2021.
//

import Foundation
import UIKit

class RacesView: UIView {
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dummyTextView, tempButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum"
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var dummyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sem fringilla ut morbi tincidunt augue interdum. Ut morbi tincidunt augue interdum velit euismod in pellentesque massa. Pulvinar etiam non quam lacus suspendisse faucibus interdum posuere. Mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a. Eget nullam non nisi est sit amet. Odio pellentesque diam volutpat commodo. Id eu nisl nunc mi ipsum faucibus vitae."
        return textView
    }()
    
    lazy var tempButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present Modal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = tintColor
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    weak var delegate: RacesViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configureView()
        configureConstraints()
        tempButton.addTarget(self, action: #selector(tempButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard initialization not implemented for RacesView")
    }
    
    func configureView() {
        backgroundColor = .systemBackground
    }
    
    func configureConstraints() {
        addSubview(containerStackView)
        
        let safeArea = safeAreaLayoutGuide
        
        containerStackView.anchor(top: safeArea.topAnchor, paddingTop: 16, bottom: safeArea.bottomAnchor, paddingBottom: 16, left: safeArea.leftAnchor, paddingLeft: 16, right: safeArea.rightAnchor, paddingRight: 16)
    }
    
    @objc func tempButtonTapped() {
        delegate?.tempButtonTapped()
    }
    
}
