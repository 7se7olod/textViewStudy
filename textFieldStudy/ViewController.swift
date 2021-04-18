//
//  ViewController.swift
//  textFieldStudy
//
//  Created by Всеволод on 17.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        textView.delegate = self
        textView.textColor = .white
        textView.backgroundColor = .none
        textView.font = UIFont(name: "Avenir", size: 20)
        textView.layer.cornerRadius = 10
        
        outletStepper.value = 20
        outletStepper.minimumValue = 15
        outletStepper.maximumValue = 25
        outletStepper.layer.cornerRadius = 10
        outletStepper.tintColor = .white
        outletStepper.backgroundColor = .brown
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
    textView.resignFirstResponder() // скрытие клавиатуры для конкретного объекта
    
   }
    
    @objc func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
              else { return }
            
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: keyboardFrame.height - textViewButtonConstraint.constant,
                                                 right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
            textView.scrollRangeToVisible(textView.selectedRange)
        }
    
    
    @IBOutlet weak var outletStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewButtonConstraint: NSLayoutConstraint!
    
    @IBAction func stepper(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontSize = CGFloat (sender.value)
        textView.font = UIFont.init(name: font!, size: fontSize)
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = .none
        textView.textColor = .white
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        return textView.text.count + (text.count - range.length) <= 60
    }
    
}

