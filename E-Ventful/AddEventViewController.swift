//
//  AddEventViewController.swift
//  
//
//  Created by Drake Neuenschwander on 1/27/22.
//

import UIKit
import SwiftUI


class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    //variables for this view controller
   
    @IBOutlet weak var tbl_view: UITableView!
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
    var selectionEvent: [String] = []
    var selectionTime: [String] = []
//    let loadingQueue = OperationQueue()
//    var loadingOperations = [IndexPath : AddEventViewController]()
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //tbl_view?.prefetchDataSource = self
        
        //custom textbox file for the custom picker this allows for the text to be saved as a data source.
        activityTxt.inputView = activityPicker
        
        //Custom picker allowing delegation of this file and the data in this file.
        activityPicker.delegate = self
        activityPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        fromDateTxt.inputView = datePicker
        toDate.inputView = datePicker
        startTimeTxt.inputView = datePicker
        
        // Universal done button for all wheel options
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton] , animated: true)
        fromDateTxt.inputAccessoryView = toolBar
        toDate.inputAccessoryView = toolBar
        activityTxt.inputAccessoryView = toolBar
        startTimeTxt.inputAccessoryView = toolBar
        
        
        }
    //Lists for the mini event and the time.

    
    @IBAction func addBtn(_ sender: UIButton) {

        if let item = activityTxt.text, item.isEmpty == false { // need to make sure we have something here
            selectionEvent.append(item) // store it in our data holder
        }
        
        if let item = startTimeTxt.text, item.isEmpty == false { // need to make sure we have something here
            selectionTime.append(item) // store it in our data holder
        }
        
        startTimeTxt.text = nil // clean the textfield input
        activityTxt.text = nil // clean the textfield input
        
        self.loadData()
        
        
        for product in selectionTime {
            print(product)
        }
        for product in selectionEvent {
            print(product)
                }
    }
    
    func loadData() {
        // code to load data from network, and refresh the interface
        tbl_view.reloadData()
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

extension AddEventViewController: UIPickerViewDataSource, UIPickerViewDelegate { //UITableViewDataSourcePrefetching UITableViewDelegate, UITableViewDataSource{
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectionEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID")
        
        let activityText = selectionEvent[indexPath.row]
        let timeText = selectionTime[indexPath.row]
        
        if let tableViewCell = tableViewCell as? TableViewCell {
            tableViewCell.activityTableTxt.text = "                        " + timeText
        }
        if let tableViewCell = tableViewCell as? TableViewCell {
            tableViewCell.startTableTimeTxt.text = "     " + activityText
        }
//        let activityText = selectionEvent[indexPath.row]
//
//        //tableViewCell.activityTypeTxt.text = activityText
//
//        let timeText = selectionTime[indexPath.row]
//
//        tableViewCell.startTableTimeTxt.text = activityText + timeText
//
        return tableViewCell!
    }
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPath: [IndexPath]) {
//        for indexPath in indexPath {
//            if let _ = loadingOperations[indexPath] {return}
//            if let dataLoader = selectionTime
//        }
//    }

}
