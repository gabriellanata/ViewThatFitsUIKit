//
//  ViewThatFits.swift
//  ViewThatFitsUIKit
//
//  Created by Gabriel Lanata on 12/9/22.
//

import UIKit

class ViewThatFits: UIView {
    private let possibleSubviews: [UIView]
    private var currentSubview: UIView?

    init(possibleSubviews: [UIView]) {
        self.possibleSubviews = possibleSubviews
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        print("LayoutSubviews", self.bounds.size.width)
        let availableWidth = self.bounds.size.width // This width is not always what we want
        let idealSubview = self.idealSubview(for: availableWidth)
        if idealSubview != self.currentSubview {
            self.currentSubview?.removeFromSuperview()
            self.currentSubview = idealSubview
            self.fillWithSubview(idealSubview)
        }

        super.layoutSubviews()
    }

    // Helpers

    private func idealSubview(for availableWidth: CGFloat) -> UIView {
        return self.possibleSubviews.first { subview in
            let targetSize = CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height)
            let subviewSize = subview.systemLayoutSizeFitting(targetSize,
                                                              withHorizontalFittingPriority: .defaultHigh,
                                                              verticalFittingPriority: .fittingSizeLevel)
            return availableWidth >= subviewSize.width
        } ?? self.errorView()
    }

    private func fillWithSubview(_ subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    private func errorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
}
