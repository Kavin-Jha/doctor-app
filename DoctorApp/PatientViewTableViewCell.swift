//
//  PatientViewTableViewCell.swift
//  DoctorApp
//
//  Created by Kavin Jha on 24/07/23.
//

import UIKit



class PatientViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var patientNameLabel: UILabel!
    
    
    @IBOutlet weak var AppointmentDateLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
