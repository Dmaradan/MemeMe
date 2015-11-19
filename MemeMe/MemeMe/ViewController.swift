//
//  ViewController.swift
//  MemeMe-v1.0
//
//  Created by Diego Martin on 10/14/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var originVC: String!
    
    var userEditing = false
    
    //MARK: Outlets
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var camButton: UIBarButtonItem!
    
    //MARK: Life-cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.enabled = false
        setText()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        //disable camera button if device does not support it
        camButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setText() {
        
        let texts = [topText, bottomText]
        
        if userEditing == false {
            
            topText.text = "TOP"
            bottomText.text = "BOTTOM"
        }
        
        for text in texts {
            
            text.delegate = self
            text.textAlignment = .Center
            text.defaultTextAttributes = memeTextAttributes
        }
    }
    
    
    //MARK: Globals
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    
    //MARK: Button actions
    
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        
        let image = generateMemedImage()
        let activityItems = [image]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        save()
        
        presentViewController(activityVC, animated: true, completion: nil)
        //navigationController?.popToRootViewControllerAnimated(false)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        //dismissViewControllerAnimated(true, completion: nil)
        if originVC == "tableView"{
            
            performSegueWithIdentifier("unwindMemeEditor", sender: sender)
        } else {
            
            performSegueWithIdentifier("unwindMemeEditorToCollectionView", sender: sender)
        }
        
    }
    
    
    
    //MARK: Delegate methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
            dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
        }
    }
    
    //Fix visibility bug where user starts editing top text from the edit-bottom view without
    //having typed anything for the bottom, making the bottom text field invisible afterwards.
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if(textField.text == ""){
            textField.text = "EDIT ME"
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: NS Notifications
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: Keyboard methods
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: Meme saving
    
    func generateMemedImage() -> UIImage
    {
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return memedImage
    }
    
    func save() {
        
        // TODO: hide nav and tool bars before saving
        
        // Create the meme
        let memedImage = generateMemedImage()
        var meme = Meme(top: topText.text!, bottom: bottomText.text!, image: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        SentMemes.add(meme)
    }
}

