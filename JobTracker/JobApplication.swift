//
//  JobApplication.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/15/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit
import os.log

class JobApplication: NSObject, NSCoding {
    
    //MARK: Properties
    
    var title: String
    var company: String
    var location: String?
    var poc: String?
    var date: String?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("jobApplications")
    
    //MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let company = "company"
        static let location = "location"
        static let poc = "poc"
        static let date = "date"
    }
    
    //MARK: Initialization
    
    init(title: String, company: String, location: String?, poc: String?, date: String?) {
        self.title = title
        self.company = company
        self.location = location
        self.poc = poc
        self.date = date
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(company, forKey: PropertyKey.company)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(poc, forKey: PropertyKey.poc)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for a JobApplication object.", log: OSLog.default, type: .debug)
            return nil
        }
        let company = aDecoder.decodeObject(forKey: PropertyKey.company) as! String
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String
        let poc = aDecoder.decodeObject(forKey: PropertyKey.poc) as? String
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        
        // Must call designated initializer.
        self.init(title: title, company: company, location: location, poc: poc, date: date)
        
    }
}
