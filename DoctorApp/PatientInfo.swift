//
//  PatientInfo.swift
//  DoctorApp
//
//  Created by Kavin Jha on 25/07/23.
//

import Foundation

class Information: Comparable {
    
    static func < (lhs: Information, rhs: Information) -> Bool {
        return lhs.appointmentDate < rhs.appointmentDate
    }
    
    static func > (lhs: Information, rhs: Information) -> Bool {
        return lhs.appointmentDate > rhs.appointmentDate
    }
    
    
    static func == (lhs: Information, rhs: Information) -> Bool {
        return lhs.appointmentDate == rhs.appointmentDate
    }
    
    
   // var id: String
    var name: String
    var cardNumber: String
    var appointmentDate: Date
    var description: String

    
    init(name: String, cardNumber: String, appointmentDate: Date, description: String) {
        self.name = name
        self.cardNumber = cardNumber
        self.appointmentDate = appointmentDate
        self.description = description
    }
    
    }

