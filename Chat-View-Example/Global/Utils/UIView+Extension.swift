//
//  UIView+Extension.swift
//  Chat-View-Example
//
//  Created by Sparkout on 22/10/22.
//

import UIKit

extension UIView {
    func addCornerRadius(cornerRadius: CGFloat = 8) {
        // clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    func addShadow (_ color: UIColor, shadowRadius: CGFloat) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }

    func addBorder(_ color: UIColor, _ width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    enum BorderSide {
        case top, bottom, left, right
    }
    
    func addBorder(side: BorderSide, color: UIColor, width: CGFloat, dashed: Bool = false) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = dashed ? [6, 3] : []
        let size = shapeLayer.frame.size
        let pointA: CGPoint
        let pointB: CGPoint
        
        self.addSubview(border)
        
        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)

        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
            pointA = CGPoint.zero
            pointB = CGPoint(x: size.width - 40, y: 0)
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
            pointA = CGPoint(x: 0, y: 0)
            pointB = CGPoint(x: 0, y: size.height)
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
            pointA = CGPoint(x: 0, y: size.height - 40)
            pointB = CGPoint(x: size.width - 40, y: size.height - 40)
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
            pointA = CGPoint.zero
            pointB = CGPoint(x: 0, y: size.height)
        }
        let path = CGMutablePath()
        path.addLines(between: [pointA, pointB])
        shapeLayer.path = path
        border.layer.addSublayer(shapeLayer)
    }
}

extension UITableView {

    func scrollToBottom(isAnimated:Bool = true){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }

    func scrollToTop(isAnimated:Bool = true) {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
           }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
