//
//  CardViewController.swift
//  RealityLang
//
//  Created by Jake Moskowitz on 10/7/17.
//  Copyright © 2017 JLMP Enterprises. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UIGestureRecognizerDelegate {
	
	var isNativeLang = true
	var image: UIImage?
	var nativePhrase: String?
	var translatedPhrase: String?

	@IBOutlet var photoImageView: UIImageView!
	@IBOutlet var phraseLabel: UILabel!
	
	init(imageData: NSData, nativePhrase: String, translatedPhrase: String) {
		super.init(nibName: "CardViewController", bundle: nil)
		let image = UIImage(data: imageData as Data)
		self.image = image
		self.nativePhrase = nativePhrase
		self.translatedPhrase = translatedPhrase
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.photoImageView.image = self.image
		self.phraseLabel.text = self.nativePhrase
		
		let tapPhrase = UITapGestureRecognizer(target: self, action: #selector(togglePhrase(_:)))
		self.phraseLabel.addGestureRecognizer(tapPhrase)
	}
	
	@objc func togglePhrase(_ sender: UITapGestureRecognizer) {
		self.phraseLabel.text = self.isNativeLang ? self.translatedPhrase : self.nativePhrase
	}

}
