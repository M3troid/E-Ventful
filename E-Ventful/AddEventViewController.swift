//
//  AddEventViewController.swift
//  
//
//  Created by Drake Neuenschwander on 1/27/22.
//

import UIKit

class AddEventViewController: UIViewController {

    
    @IBOutlet weak var miniEventDate: UITextField!
    @IBOutlet weak var startTimeTxt: UITextField!
    @IBOutlet weak var activityTxt: UITextField!
    @IBOutlet weak var scrollerView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var toDate: UITextField!
    var toolBar = UIToolbar()
    var dateFormatter = DateFormatter()
    var activityPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let miniEvent = ["Activity","Meeting","Meal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTxt.inputView = activityPicker
        
        activityPicker.delegate = self
        activityPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        fromDateTxt.inputView = datePicker
        toDate.inputView = datePicker
        startTimeTxt.inputView = datePicker
        
        
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton] , animated: true)
        fromDateTxt.inputAccessoryView = toolBar
        toDate.inputAccessoryView = toolBar
        activityTxt.inputAccessoryView = toolBar
        startTimeTxt.inputAccessoryView = toolBar
        
      
        }
    
    func createDatePickerView(_ textField: UITextField){
        
        if textField == fromDateTxt
            {
            datePicker.datePickerMode = .date
        }
        if textField == toDate
            {
            datePicker.datePickerMode = .date
        }
        if textField == startTimeTxt
        {
            datePicker.datePickerMode = .time
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
        if startTimeTxt.isFirstResponder {
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            startTimeTxt.text = dateFormatter.string(from: datePicker.date)
        }
        
        self.view.endEditing(true)
    }

}

extension AddEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return miniEvent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return miniEvent[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return activityTxt.text = miniEvent[row]
    }
}
