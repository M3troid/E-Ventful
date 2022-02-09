//
//  AddEventViewController.swift
//  
//
//  Created by Drake Neuenschwander on 1/27/22.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        fromDate.text = formatter.string(from:datePicker.date)
    }
    


}
