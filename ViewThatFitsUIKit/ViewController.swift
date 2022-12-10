//
//  ViewController.swift
//  ViewThatFitsUIKit
//
//  Created by Gabriel Lanata on 12/9/22.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // CONTAINER
        // We create a gray container view that we can dynamically change in width. We could have been set
        // the constraints directly on viewThatFits, but this makes it easier to visualize.

        let someContainer = UIView()
        someContainer.backgroundColor = UIColor.lightGray
        someContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(someContainer)
        NSLayoutConstraint.activate([
            someContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            someContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            someContainer.heightAnchor.constraint(equalToConstant: 200),
        ])

        let maxWidthConstraint = someContainer.widthAnchor.constraint(equalToConstant: 300)
        maxWidthConstraint.isActive = true

        // CONTROLS
        // We create a couple of buttons to adjust the width of the container view.

        let controlsStack = UIStackView(arrangedSubviews: [
            UIButton(type: .roundedRect, primaryAction: UIAction(title: "- Width") { _ in
                maxWidthConstraint.constant -= 20
            }),
            UIButton(type: .roundedRect, primaryAction: UIAction(title: "+ Width") { _ in
                maxWidthConstraint.constant += 20
            }),
        ])
        controlsStack.spacing = 16
        controlsStack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(controlsStack)
        NSLayoutConstraint.activate([
            controlsStack.topAnchor.constraint(equalTo: someContainer.bottomAnchor, constant: 40),
            controlsStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])

        // SUBVIEW OPTIONS
        // We create three subviews with different hardcoded widths to use as the possible subviews to choose
        // from. They have different colors and a size label to identify which one we're seeing.

        let subviewA = UILabel()
        subviewA.text = "L"
        subviewA.textAlignment = .center
        subviewA.backgroundColor = .green
        let subviewB = UILabel()
        subviewB.text = "M"
        subviewA.textAlignment = .center
        subviewB.backgroundColor = .yellow
        let subviewC = UILabel()
        subviewC.text = "S"
        subviewA.textAlignment = .center
        subviewC.backgroundColor = .purple
        NSLayoutConstraint.activate([
            subviewA.widthAnchor.constraint(equalToConstant: 200),
            subviewB.widthAnchor.constraint(equalToConstant: 100),
            subviewC.widthAnchor.constraint(equalToConstant: 50),
        ])

        // VIEWTHATFITS
        // We create our ViewThatFits component and pass the subview options to it. We insert the component
        // into the previously created container, but we let it be smaller than the container so it can pick
        // its own size.

        let viewThatFits = ViewThatFits(possibleSubviews: [subviewA, subviewB, subviewC])
        viewThatFits.backgroundColor = UIColor.blue
        viewThatFits.translatesAutoresizingMaskIntoConstraints = false
        someContainer.addSubview(viewThatFits)
        NSLayoutConstraint.activate([
            viewThatFits.topAnchor.constraint(equalTo: someContainer.topAnchor),
            viewThatFits.bottomAnchor.constraint(equalTo: someContainer.bottomAnchor),
            viewThatFits.leadingAnchor.constraint(equalTo: someContainer.leadingAnchor),
            viewThatFits.trailingAnchor.constraint(lessThanOrEqualTo: someContainer.trailingAnchor),
        ])
    }
}
