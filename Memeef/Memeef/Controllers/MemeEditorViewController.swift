//
//  ViewController.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-02.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var ShareButton: UIBarButtonItem!
   
    // MARK: Text Field Delegate objects
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if the Camera  is enabled in the device
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
             
        // set text field properties
        textFieldAttributes(textField: topTextField, defaultText: meme.topText)
        textFieldAttributes(textField: bottomTextField, defaultText: meme.bottomText)
        // Hide keyboard
        subscribeToUIKeyboardNotifications()
        //disable share button
        ShareButton.isEnabled = false
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    @objc func keyboardWillHide(notification: Notification){
        view.frame.origin.y = 0
    }
    
    func subscribeToUIKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func pickImage(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView?.image = image
            ShareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
            imagePickerView.contentMode = .scaleAspectFit
        }
    }
    func textFieldAttributes( textField: UITextField, defaultText: String) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor:UIColor.black,
            .foregroundColor:UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth: -3.0
            ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
        // set delegates for textField
        textField.delegate = textFieldDelegate
    }
    // Initialize Meme
    let meme = Meme( topText: "TOP", bottomText: "BOTTOM",originalImage: nil, memedImage: nil)
    
    @IBAction func CancelButton(_ sender: Any) {
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
        imagePickerView.image = meme.originalImage
        dismiss(animated: true, completion: nil)
    }
    func generateMemedImage() -> UIImage {
        HideToolbar(hide: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        HideToolbar(hide: false)
        return memedImage
        }
    
    @IBAction func share() {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
       
        controller.completionWithItemsHandler = {(type,completed,items,error) in
            if completed{
            let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imagePickerView.image, memedImage: memedImage)
        
            // Add it to the memes array in the Application Delegate
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            // dismiss(animated: true, completion: nil)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    // To hide and activate Toolba
    func HideToolbar( hide: Bool)  {
        topToolbar.isHidden = hide
        bottomToolbar.isHidden = hide
    }
}


   
  





