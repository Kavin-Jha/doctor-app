//
//  ViewController.swift
//  DoctorApp
//
//  Created by Kavin Jha on 24/07/23.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var patientViewTableView: UITableView!
    
    var databaseRef : DatabaseReference?
    var patientInfo = [Information]()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllData()
        patientViewTableView.backgroundColor = .white
        patientViewTableView.register(UINib(nibName: "PatientViewTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientViewTableViewCell")
        patientViewTableView.estimatedRowHeight = 100
        patientViewTableView.rowHeight = UITableView.automaticDimension
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)) , for: .valueChanged)
        patientViewTableView.refreshControl = refreshControl
    }
    
    @objc func pullToRefresh(sender: UIRefreshControl){
        
        patientInfo.removeAll()
        getAllData()
        self.patientViewTableView.refreshControl?.endRefreshing()
        
    }
    
    func getAllData(){
        
        databaseRef = Database.database().reference().child("PatientInfo")
        
        databaseRef?.getData(completion: { [weak self] error, snapshot in
            
            guard  let valueArray = snapshot?.value as? [String: Any] else {return}
            
            valueArray.forEach { key, value in
                
                if let dict = value as? [String: String],
                   
                    let name = dict["name"],
                   
                    let cardNumber = dict["cardNumber"],
                   
                    let AppointmentDate = dict["AppointmentDate"],
                   
                    let Description = dict["Description"] {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy"
               let actualDate = dateFormatter.date(from: AppointmentDate)
                    
                    let information = Information(name: name, cardNumber: cardNumber, appointmentDate: actualDate!, description: Description)
                    self?.patientInfo.append(information)
                    
//                    let df = DateFormatter()
//                    df.dateFormat = "MMM d, yyyy"
//                    df.locale = Locale(identifier: "en_US_POSIX")
//                    df.timeZone = TimeZone(identifier: "UTC")!
//
                  
                   // let sortedArray = AppointmentDate.sorted {df.date(from: $0)! > df.date(from: $1)!}
                    
                   // self!.patientInfo.sort(by: {$0.name > $1.name})
                }
                
                else{
                    print("nothing")
                }
            }
            
            let sortedArray = self?.patientInfo.sorted(by: { $0 < $1 })
            print("Fix: \(sortedArray?.first?.appointmentDate) and Last: \(sortedArray?.last?.appointmentDate)")
            
            self?.patientInfo.removeAll()
            self?.patientInfo = sortedArray ?? []
            
            
            if (self?.patientInfo.count ?? 0) > 0 {
                
                self?.patientViewTableView.reloadData()
                //self?.monitorNewData()
            }
            
        })
        
//        databaseRef?.observe(.childAdded){ [weak self](snapshot) in
//
////            let key = snapshot.key
//           guard  let value = snapshot.value as? [String: Any] else {return}
//
//            if let text = value["text"] as? String {
//                let information = Information(info: text)
//                self?.patientInfo.append(information)
//
//                print(self?.patientInfo.count)
//            }
            
        //}
        
    }
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientInfo.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PatientViewTableViewCell? = patientViewTableView.dequeueReusableCell(withIdentifier: "PatientViewTableViewCell") as? PatientViewTableViewCell
        
        cell?.patientNameLabel.text = patientInfo[indexPath.row].name
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "MMM d, yyyy"

        // Convert Date to String
       let newDate = dateFormatter.string(from: patientInfo[indexPath.row].appointmentDate)
        
        cell?.AppointmentDateLabel.text = newDate
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
 
