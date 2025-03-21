//
//  ViewController.swift
//  BasicExample
//
//  Created by Deepa on 26/12/22.
//

import UIKit
import Journify

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Unique Id for Segment
        Journify.main.identify(userId: "Deepa")
    }

    func getFormattedDate() -> String? {
        let format = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.titleLabel.text = Rows.allCases[indexPath.row].rawValue
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRowSelected = Rows.allCases[indexPath.row]
        switch currentRowSelected {
        case .setPhone:
            let phoneTrait = ["phone": "00212666666666"]
            Journify.main.identify(traits: phoneTrait)
        case .setGender:
            let genderTrait = ["gender": "male"]
            Journify.main.identify(traits: genderTrait)
        case .setLastName:
            let lastNameTrait = ["lastName": "lnu"]
            Journify.main.identify(traits: lastNameTrait)
        case .setFirstName:
            let firstNameTrait = ["firstName": "fnu"]
            Journify.main.identify(traits: firstNameTrait)
            Journify.main.identify(traits: firstNameTrait)
        case .setEmail:
            let emailTrait = ["email": "test@testJournify.com"]
            Journify.main.identify(traits: emailTrait)
        case .setBirthdate:
            let birthdayTrait = ["birthday": Date()]
            Journify.main.identify(traits: birthdayTrait)
        case .setisoBirthDay:
            let isoBirthdayTrait = ["isoBirthday": getFormattedDate()]
            Journify.main.identify(traits: isoBirthdayTrait)
        case .setisoDate:
            let isoDateTrait = ["isoDate": getFormattedDate()]
            Journify.main.identify(traits: isoDateTrait)
        case .setLocation:
            let locationTrait = ["location": ["latitude":74.0, "longitude": 78.0]]
            Journify.main.identify(traits: locationTrait)
        case .trackEvents:
            var events = [String:Any]()
            events["dupe"] = "default"
            events["general"] = "value"
            events["audioPlayed"] = "Dangerous"
            events["artist"] = "David Garrett"
            events["testDate"] = getFormattedDate()
            events["testDate2"] = getFormattedDate()
            Journify.main.track(name: "Test_123", properties: events)
        case .flush:
            Journify.main.flush()
        case .resetUser:
            Journify.main.reset()
        }
        
    }
}

enum Rows: String, CaseIterable {
    case setPhone = "Set Phone Number"
    case setGender = "Set Gender"
    case setLastName = "Set LastName"
    case setFirstName = "Set FirstName"
    case setEmail = "Set Email"
    case setBirthdate = "Set Birthday"
    case setisoBirthDay = "Set ISO birthday"
    case setisoDate = "Set ISO date"
    case setLocation = "Set Location"
    case trackEvents = "Track Events"
    case flush = "Flush Data"
    case resetUser = "Reset User"
}
