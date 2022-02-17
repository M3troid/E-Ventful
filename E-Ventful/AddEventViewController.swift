//
//  AddEventViewController.swift
//  
//
//  Created by Drake Neuenschwander on 1/27/22.
//

import UIKit

class AddEventViewController: UIViewController {

    
    
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var toDate: UITextField!
    var toolBar = UIToolbar()
    var dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fromDateTxt.inputView = datePicker
        toDate.inputView = datePicker
        
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton] , animated: true)
        fromDateTxt.inputAccessoryView = toolBar
        toDate.inputAccessoryView = toolBar
        

      
                                         }
    
    func createDatePickerView(_ textField: UITextField){
        
        datePicker.preferredDatePickerStyle = .wheels
        
        if textField == fromDateTxt
            {
            datePicker.datePickerMode = .date
        }
        if textField == toDate
            {
            datePicker.datePickerMode = .date
        }
    }
    @objc func doneButtonTapped() {
        if fromDateTxt.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            fromDateTxt.text = dateFormatter.string(from: datePicker.date)
        }
        if toDate.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            toDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }

}
