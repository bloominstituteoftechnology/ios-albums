//
//  Extensions.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/4/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

extension UITextField {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
}
