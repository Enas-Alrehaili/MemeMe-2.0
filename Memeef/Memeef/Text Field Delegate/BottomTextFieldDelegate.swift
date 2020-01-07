//
//  BottomTextFieldDelegate.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-03.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
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
      
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // @TODO: Set the color of your text here!
        return true
    }
    

}

