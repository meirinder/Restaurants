//
//  AddReviewViewController.swift
//  Restaurants
//
//  Created by Savely on 19.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextView.text = "Your message"
        messageTextView.textColor = UIColor.lightGray
    messageTextView.translatesAutoresizingMaskIntoConstraints = true
        messageTextView.sizeToFit()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendAction(_ sender: Any) {
        

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
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        if newFrame.height > 50 {
            return
        }
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
