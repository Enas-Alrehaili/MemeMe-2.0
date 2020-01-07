//
//  TextFieldDelegate.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-28.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    var firstTime = true
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstTime{
            textField.text = ""
            firstTime = false
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}

