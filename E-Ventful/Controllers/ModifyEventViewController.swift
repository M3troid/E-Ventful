//
//  AddEventViewController.swift
//
//
//  Created by Drake Neuenschwander on 1/27/22.
// This view allows the user to easily modify their event name and the times the event was scheduled for.
//

//Imports for firebase authentication and database
import FirebaseAuth
import FirebaseDatabase
import UIKit


class ModifyEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    
    //variables for this view controller
    var events = [Event]()
    var ref: DatabaseReference!
    var eventName = String()
    var eventDateFrom = String()
    var eventToDate = String ()
    var eventID = String()
    @IBOutlet weak var eventNameTxt: UITextField!
    @IBOutlet weak var tbl2_view: UITableView!
    @IBOutlet weak var tbl_view: UITableView!
    @IBOutlet weak var startTimeTxt: UITextField!
    @IBOutlet weak var activityTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
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
    var selectionName: [String] = []
    var selectionNumber: [String] = []
    let userID = Auth.auth().currentUser?.uid

    //  this loads function before the view fully loads in or starts its everytime something is updated in the database.
    override func viewDidLoad() {
    
        super.viewDidLoad()
    
        eventNameTxt.text! = eventName
        fromDateTxt.text! = eventDateFrom
        toDate.text! = eventToDate
        print (eventName)
//        eventNameTxt.text = "Event Name"
//        toDate.text = ""
//        fromDateTxt.text = ""
//        selectionEvent.removeAll()
//        selectionTime.removeAll()
//        selectionName.removeAll()
//        selectionNumber.removeAll()
        
        
        
        // database loading
        self.ref = Database.database().reference()
        
        //textfield phone number format
        phoneTxt.delegate = self
        
        //TableView setup
        tbl_view.delegate = self
        tbl2_view.delegate = self
        tbl_view.dataSource = self
        tbl2_view.dataSource = self
        
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
    //
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
    
  
    // button that adds a attendent to the event.
    @IBAction func attendeeAddBtn(_ sender: Any) {
        
        if let item = nameTxt.text, item.isEmpty == false { // need to make sure we have something here
            selectionName.append(item) // store it in our data holder
        }
        
        if let item = phoneTxt.text, item.isEmpty == false { // need to make sure we have something here
            selectionNumber.append(item) // store it in our data holder
        }
        
        nameTxt.text = nil // clean the textfield input
        phoneTxt.text = nil // clean the textfield input
        
        self.loadData2()
    }

    //updates the event data at the  given event from the tableview.
    func updateEvent() {
        
        let eventName = eventNameTxt.text!
        let eventFromDate = fromDateTxt.text!
        let eventToDate = toDate.text!
        let eventActivity = selectionEvent
        let eventActivityTime = selectionTime
        let attendeeName = selectionName
        let attendeePhone = selectionNumber
        let randomID = DatabaseService.shared.eventRef.child(userID!).child("Events").child(eventID)
        let parameters = ["eventName": eventName,
                          "eventFromDate": eventFromDate,
                          "eventToDate": eventToDate,
                          "activity": eventActivity,
                          "time": eventActivityTime,
                          "attendeeName": attendeeName,
                          "attendeePhone": attendeePhone,
                          "randomID": randomID.key!] as [String : Any]
        
        DatabaseService.shared.eventRef.child(userID!).child("Events").child(eventID).setValue(parameters)
        
        eventNameTxt.text = "Event Name"
        toDate.text = ""
        fromDateTxt.text = ""
        selectionEvent.removeAll()
        selectionTime.removeAll()
        selectionName.removeAll()
        selectionNumber.removeAll()
        
        self.tbl2_view.reloadData()
        self.tbl_view.reloadData()
        
    }
    //dissmisses the view if the button is exit pressed.
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // this allows for the create update event function to be pressed.
    @IBAction func updEvent(_ sender: Any) {
        updateEvent()
        dismissView((Any).self)
    }
    func loadData() {
        // code to load data from network, and refresh the interface
        tbl_view.reloadData()
    }
    
    func loadData2() {
        tbl2_view.reloadData()
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
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

extension ModifyEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "(XXX)-XXX-XXXX", phone: newString)
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return miniEvent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        activityTxt.text = miniEvent[row]
        return miniEvent[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return activityTxt.text = miniEvent[row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case tbl_view:
            numberOfRow = selectionEvent.count
        case tbl2_view:
            numberOfRow = selectionName.count
        default:
            print("Some things are wrong")
        }
        
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            var cell = UITableViewCell()
            switch tableView {
            case tbl_view:
                cell = tableView.dequeueReusableCell(withIdentifier: "tbl_view", for: indexPath)
                        let activityText = selectionEvent[indexPath.row]
                        let timeText = selectionTime[indexPath.row]
                
                if let cell = cell as? TableViewCell {
                    cell.activityTableTxt.text = "                        " + timeText
                        }
                if let cell = cell as? TableViewCell {
                    cell.startTableTimeTxt.text = "     " + activityText
                }
            
            case tbl2_view:
                cell = tableView.dequeueReusableCell(withIdentifier: "tbl2_view", for: indexPath)
                    let nameText = selectionName[indexPath.row]
                    let phoneInt = selectionNumber[indexPath.row]
        
                if let cell = cell as? TableViewCell {
                    cell.nameTableTxt.text = "       " + nameText
                    }
                if let cell = cell as? TableViewCell {
                    cell.phoneTableText.text = "                          " + phoneInt
                }
            default:
                print("Some things are wrong")
                }
            return cell
            }

    }



