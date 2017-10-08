//
//  Storage.swift
//  RealityLang
//
//  Created by Jake Moskowitz on 10/7/17.
//  Copyright © 2017 JLMP Enterprises. All rights reserved.
//

import Foundation

private let defaults = UserDefaults.standard

struct Storage {
	
	static var images: Array<Any>? {
		set {
			defaults.setValue(newValue, forKey: "images")
		}
		get {
			return defaults.array(forKey: "images") as! Array?
		}
	}
	
	static var cards: NSMutableArray? {
		set {
			defaults.setValue(newValue, forKey: "cards")
		}
		get {
			return defaults.array(forKey: "cards") as! NSMutableArray?
		}
	}
	
	static var currentImage: NSData? {
		set {
			defaults.setValue(newValue, forKey: "currentImage")
		}
		get {
			return defaults.data(forKey: "currentImage") as NSData?
		}
	}
	
	static var currentIndex: Int? {
		set {
			defaults.setValue(newValue, forKey: "currentIndex")
		}
		get {
			return defaults.integer(forKey: "currentIndex") as Int?
		}
	}
}
