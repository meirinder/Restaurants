//
//  AddReviewViewController.swift
//  Restaurants
//
//  Created by Savely on 19.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var addReviewViewModel = AddReviewViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.layer.borderWidth = 1
        messageTextView.text = "Your message"
        messageTextView.textColor = UIColor.lightGray
        textViewDidChange(messageTextView)
        activityIndicator.isHidden = true
        messageTextView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if (!((authorNameTextField.text?.isEmpty)!)) && (!(messageTextView!.text == "Your message")){
            addReviewViewModel.sendReview(text: messageTextView.text, author: authorNameTextField.text!){ success in
                DispatchQueue.main.async {
                    if success {
                        self.alert(titleMessage: "Notify", message: "Your Comment is posted", titleAction: "OK")
                    }else{
                        self.alert(titleMessage: "Error", message: "Internet connection required", titleAction: "OK")
                    }
                    self.messageTextView.isEditable = true
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
            authorNameTextField.text = ""
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            messageTextView.isEditable = false
            messageTextView.text = ""
            
        }else {
            alert(titleMessage: "Error", message: "Fill in all the fields before sending", titleAction: "I'll fill")
        }
        
    }
    
    func alert(titleMessage:String, message: String, titleAction: String){
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleAction, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your message"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame

        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: min(((textView.font?.pointSize)!+6)*3, newSize.height))
        textView.frame = newFrame
        
    }

}
