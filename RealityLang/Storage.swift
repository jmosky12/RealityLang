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
	
	static var images: NSArray? {
		set {
			defaults.setValue(newValue, forKey: "images")
		}
		get {
			return defaults.array(forKey: "images") as NSArray?
		}
	}
	
	static var cards: NSArray? {
		set {
			defaults.setValue(newValue, forKey: "cards")
		}
		get {
			return defaults.array(forKey: "cards") as NSArray?
		}
	}
}
