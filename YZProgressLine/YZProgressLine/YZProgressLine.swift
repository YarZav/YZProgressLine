//
//  YZProgressLine.swift
//  YZProgressLine
//
//  Created by admin on 27/05/2019.
//  Copyright © 2019 YZO. All rights reserved.
//

import UIKit

// MARK: - YZProgressLine
open class YZProgressLine: UIView {
    
    /// Start percent when start laoding it can be not 0 %, but 5 % or something else
    public static var startPercent: CGFloat = 10
    
    /// Background progress line color
    public static var fillColor: UIColor = .green
    
    /// Progress line background color
    public let progressLineHeight: CGFloat = 2
    
    /// Animation duration for update progress line
    public var animationUpdateDuration: TimeInterval = 0.1
    
    /// Flag to check is in progress
    public var isInProgress: Bool = false
    
    /// Progress line view
    private var progressLineView: UIView!
    
    /// Current progress percent
    private var progressPercent: CGFloat = 0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    public init() {
        super.init(frame: .zero)
        self.createUI()
    }
}

// MARK: - Privates
extension YZProgressLine {
    
    private func createUI() {
        self.backgroundColor = UIColor.clear
        
        self.progressLineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.progressLineHeight))
        self.progressLineView.clipsToBounds = true
        self.progressLineView.backgroundColor = YZProgressLine.fillColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.progressLineHeight).isActive = true
    }
    
    private func updateProgress() {
        if self.progressLineView.superview == nil {
            self.addSubview(self.progressLineView)
        }
        
        self.progressLineView.frame.size.width = self.bounds.size.width * (self.progressPercent / 100.0)
    }
    
    private func updateProgressLine(width: CGFloat, duration: TimeInterval, callback: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: {
            self.progressLineView.frame.size.width = width
        }, completion: { (success) in
            callback?(success)
        })
    }
}

// MARK: - Publics
extension YZProgressLine {
    
    /// Show progress line when started loading
    public func startLoading(animated: Bool) {
        self.isInProgress = true
        self.progressLineView.alpha = 1
        
        let duration = animated ? self.animationUpdateDuration : 0
        let newWidth = self.frame.size.width * (YZProgressLine.startPercent / 100.0)
        self.updateProgressLine(width: newWidth, duration: duration) { (success) in
            self.progressPercent = YZProgressLine.startPercent
        }
    }
    
    /// Hide progress line when stopped loading
    public func stopLoading(animated: Bool) {
        let duration = animated ? self.animationUpdateDuration : 0
        self.updateProgressLine(width: self.frame.size.width, duration: duration) { (success) in
            if !success { return }
            self.progressLineView.removeFromSuperview()
            self.isInProgress = false
        }
    }
    
    /// Set new progress percent
    public func setProgressPercent(_ newProgressPercent: CGFloat, animated: Bool) {
        if self.progressPercent == newProgressPercent { return }
        
        let duration = animated ? self.animationUpdateDuration : 0
        let newWidth = self.frame.size.width * (newProgressPercent / 100.0)
        
        if self.progressPercent < newProgressPercent {
            self.updateProgressLine(width: newWidth, duration: duration) { (success) in
                if !success { return }
                self.progressPercent = newProgressPercent
            }
        }
        
        if self.progressPercent > newProgressPercent {
            self.updateProgressLine(width: 0, duration: duration) { (successBack) in
                if !successBack { return }
                self.progressPercent = 0
                self.updateProgressLine(width: newWidth, duration: duration) { (success) in
                    if !success { return }
                    self.progressPercent = newProgressPercent
                }
            }
        }
    }
    
    /// Get current progress percent
    public func getProgressPercent() -> CGFloat {
        return self.progressPercent
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.updateProgress()
    }
}
