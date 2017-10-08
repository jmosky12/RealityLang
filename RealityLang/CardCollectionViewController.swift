//
//  CardCollectionViewController.swift
//  RealityLang
//
//  Created by Jake Moskowitz on 10/7/17.
//  Copyright © 2017 JLMP Enterprises. All rights reserved.
//

import UIKit

class CardCollectionViewController: UIViewController {

	@IBOutlet var rightButton: UIButton!
	@IBOutlet var leftButton: UIButton!
	@IBOutlet var noFlashcardsLabel: UILabel!
	@IBOutlet var cardContainer: UIView!
	var imagesCount = 0
	
	init() {
		super.init(nibName: "CardCollectionViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.noFlashcardsLabel.isHidden = Storage.images != nil && Storage.images?.count != 0 ? true : false
		
		let leftButtonItem = UIBarButtonItem.init(
			title: "Camera",
			style: .done,
			target: self,
			action: #selector(presentCamera)
		)
		
		self.navigationItem.leftBarButtonItem = leftButtonItem
		
		if Storage.images != nil && Storage.images?.count != 0 {
			self.imagesCount = (Storage.images?.count)!
			let imgData = Storage.images![0]
			let card = CardViewController(imageData: imgData as! NSData, nativePhrase: "blah", translatedPhrase: "bleh")
			self.constrainInView(content: card, parentView: self.cardContainer)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	
	@objc func presentCamera() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func constrainInView(content: UIViewController, parentView: UIView) {
		self.addChildViewController(content)
		parentView.addSubview(content.view)
		content.didMove(toParentViewController: self)
		let horzConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		let vertConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		self.view!.addConstraints(horzConstraints)
		self.view!.addConstraints(vertConstraints)
		content.view.translatesAutoresizingMaskIntoConstraints = false
	}

}
