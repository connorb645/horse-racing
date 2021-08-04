//
//  ModalContainerView.swift
//  Horse Racing
//
//  Created on 03/08/2021.
//

import UIKit

class ModalContainerView: UIView {
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy private var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = backgroundDim
        view.addGestureRecognizer(dimmedViewTap)
        return view
    }()
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    lazy private var dimmedViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    
    private var maximumContainerHeight: CGFloat
    private var currentContainerHeight: CGFloat
        
    private(set) var backgroundDim: CGFloat
    private(set) var defaultHeight: CGFloat
    private(set) var dismissibleHeight: CGFloat
    private(set) weak var delegate: ModalContainerViewDelegate?
    
    /// Initializer used to create a ModalContainerView
    /// - Parameters:
    ///   - childViewController: The view controller which will be displayed in the modal container
    ///   - backgroundDim: The amount the background will be dimmed
    ///   - defaultHeight: The default height of the container view
    ///   - dismissibleHeight: The height which will trigger the container dismissal
    ///   - topPaddingWhenExpanded: The amount of top padding when the container view is fully expanded along the y axis
    ///   - delegate: The delegate which will handle any action events
    init(childViewController: UIViewController,
         backgroundDim: CGFloat = 0.6,
         defaultHeight: CGFloat = 300.0,
         dismissibleHeight: CGFloat = 200,
         topPaddingWhenExpanded: CGFloat = 64,
         delegate: ModalContainerViewDelegate?) {
        
        self.backgroundDim = backgroundDim
        self.defaultHeight = defaultHeight
        self.dismissibleHeight = dismissibleHeight
        self.currentContainerHeight = defaultHeight
        self.maximumContainerHeight = UIScreen.main.bounds.height - topPaddingWhenExpanded
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        configureView()
        configureConstraints(childViewController: childViewController)
        configurePanGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard initialization not implemented for ModalContainerView")
    }
    
    func configureView() {
        backgroundColor = .clear
    }
    
    func configureConstraints(childViewController: UIViewController) {
        addSubview(dimmedView)
        addSubview(containerView)
        containerView.addSubview(childViewController.view)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        dimmedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dimmedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dimmedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dimmedView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        childViewController.view.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor)
    }
    
    func configurePanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        
        // Figure out the new height of the container
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed: // When dragging
            if newHeight < maximumContainerHeight {
                // We are safe to keep updating the container height
                containerViewHeightConstraint?.constant = newHeight
                layoutIfNeeded()
            }
        case .ended: // Stopped dragging
            // If we stopped with a height less than our dismissible height, we should dismiss the view
            if newHeight < dismissibleHeight {
                // Call the delegating action and let the observer handle the rest
                delegate?.dismissModal()
            }
            else if newHeight < defaultHeight {
                // If the height is still below the default height, set it back to the default height, with an animation
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // If the height is below the maximum and we are dragging down, set to the default height, with an animation
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // If the height is below the maximum and we are dragging up, set to the max height, with an animation
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func animatePresentation() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
        
        dimmedView.alpha = 0.0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.backgroundDim
        }
    }
    
    func animateDismissal(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.layoutIfNeeded()
        }
        
        dimmedView.alpha = backgroundDim
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0.0
        } completion: { _ in
            completion()
        }
    }
    
    @objc func handleTap() {
        delegate?.dismissModal()
    }
}
