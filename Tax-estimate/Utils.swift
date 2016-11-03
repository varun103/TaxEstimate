//
//  Utils.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/31/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class Utility {
    
    static func readFile(filename:String, type: String) throws -> String {
        let fileURL = NSBundle.mainBundle().pathForResource(filename, ofType: type)
        
        if fileURL == nil {
            throw AppError.RunTimeError
        }
        // Read from the file
        var readString = ""
        do {
            readString = try String(contentsOfFile: fileURL!, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        return readString
    }
    
    static func csvParser(csvLine: String) -> [String]{
        return splitString(csvLine, separator: ",")
    }
    
    static func splitString(content:String, separator: String) -> [String]{
        return content.componentsSeparatedByString(separator)
    }
}
