//
//  CameraViewController.swift
//  RealityLang
//
//  Created by Jake Moskowitz on 10/7/17.
//  Copyright © 2017 JLMP Enterprises. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate,
	UINavigationControllerDelegate, UIGestureRecognizerDelegate {
	
	@IBOutlet var cancelLayer: UIView!
	@IBOutlet var noPhotoLabel: UILabel!
	@IBOutlet var cancelButton: UIView!
	@IBOutlet var photoContainerView: UIView!
	@IBOutlet var photoImageView: UIImageView!
	@IBOutlet var takePhotoButton: UIButton!
	var image: UIImage?
	
	private enum ButtonState {
		case NoPhoto
		case Translate
		case SavePhoto
		case TakeNew
	}
	
	private var buttonState = ButtonState.NoPhoto
	
	init() {
		super.init(nibName: "CameraViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.takePhotoButton.layer.cornerRadius = 6
		self.cancelLayer.layer.cornerRadius = self.cancelLayer.frame.width/2
		
//		if (Storage.currentImage != nil) {
		if buttonState == .SavePhoto || buttonState == .Translate || buttonState == .TakeNew {
			let currentImage = UIImage(data: (Storage.currentImage as! NSData) as Data)
			self.image = currentImage
			self.cancelButton.isHidden = false
			switch(buttonState) {
			case .NoPhoto:
				self.takePhotoButton.setTitle("Take Photo", for: .normal)
			case .Translate:
				self.takePhotoButton.setTitle("Translate", for: .normal)
			case .SavePhoto:
				self.takePhotoButton.setTitle("Save to Flashcards", for: .normal)
			case .TakeNew:
				self.takePhotoButton.setTitle("Take Photo", for: .normal)
			}
			self.photoImageView.isHidden = false
		} else {
			self.photoImageView.isHidden = true
			self.cancelButton.isHidden = true
			self.takePhotoButton.setTitle("Take Photo", for: .normal)
		}
		
		self.cancelButton.isUserInteractionEnabled = true
		let cancelTap = UITapGestureRecognizer(target: self, action: #selector(self.cancelImage(_:)))
		self.cancelButton.addGestureRecognizer(cancelTap)
		
		let rightButtonItem = UIBarButtonItem.init(
			title: "Flashcards",
			style: .done,
			target: self,
			action: #selector(presentFlashcards)
		)
		
		self.navigationItem.rightBarButtonItem = rightButtonItem
	}
	
	@IBAction func openCameraButton(_ sender: UIButton) {
		if buttonState == .NoPhoto {
			if UIImagePickerController.isSourceTypeAvailable(.camera) {
				let imagePicker = UIImagePickerController()
				imagePicker.delegate = self
				imagePicker.sourceType = .camera;
				imagePicker.allowsEditing = false
				self.present(imagePicker, animated: true, completion: {
					if self.buttonState == .NoPhoto {
						self.photoImageView.isHidden = true
					}
				})
			}
		} else if buttonState == .Translate {
			self.translateImage()
		} else if buttonState == .SavePhoto {
			let data = UIImageJPEGRepresentation(self.image!, 1.0) as NSData?
			Storage.currentImage = data
			Storage.images?.append(data)
			self.takePhotoButton.setTitle("Take Photo", for: .normal)
			self.buttonState = .TakeNew
		} else {
			if UIImagePickerController.isSourceTypeAvailable(.camera) {
				let imagePicker = UIImagePickerController()
				imagePicker.delegate = self
				imagePicker.sourceType = .camera;
				imagePicker.allowsEditing = false
				self.present(imagePicker, animated: true, completion: nil)
			}
		}
	}
	
	internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		self.photoImageView.image = image
		self.image = image
		if buttonState == .NoPhoto {
			self.photoImageView.isHidden = false
			self.cancelButton.isHidden = false
		}
		self.takePhotoButton.setTitle("Translate", for: .normal)
		self.buttonState = .Translate
		dismiss(animated:true, completion: nil)
	}
	
	@objc func presentFlashcards() {
		if buttonState == .SavePhoto || buttonState == .Translate || buttonState == .TakeNew {
			let data = UIImageJPEGRepresentation(self.image!, 1.0) as NSData?
			Storage.currentImage = data
		}
		let flashcardVC = CardCollectionViewController()
		self.navigationController?.pushViewController(flashcardVC, animated: true)
	}
	
	@objc func cancelImage(_ sender: UITapGestureRecognizer) {
		self.photoImageView.isHidden = true
		self.buttonState = .NoPhoto
		self.cancelButton.isHidden = true
		self.takePhotoButton.setTitle("Take Photo", for: .normal)
	}
	
	func translateImage() {
		let data = UIImageJPEGRepresentation(self.image!, 1.0) as NSData?
		Storage.currentImage = data
		// api call
		self.takePhotoButton.setTitle("Save to Flashcards", for: .normal)
		self.buttonState = .SavePhoto
	}
	
}
