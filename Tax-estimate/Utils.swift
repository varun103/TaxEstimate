//
//  Utils.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/31/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class Utility {
    
    static func readFile(_ filename:String, type: String) throws -> String {
        let fileURL = Bundle.main.path(forResource: filename, ofType: type)
        
        if fileURL == nil {
            throw AppError.runTimeError
        }
        // Read from the file
        var readString = ""
        do {
            readString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        return readString
    }
    
    static func csvParser(_ csvLine: String) -> [String]{
        return splitString(csvLine, separator: ",")
    }
    
    static func splitString(_ content:String, separator: String) -> [String]{
        return content.components(separatedBy: separator)
    }
    
    static func getFileContentsAsStringArray(fileName:String, type:String) throws -> [String] {
        let bracketInfoFileName = fileName
        let bracketInfoFileContents =  try Utility.readFile(bracketInfoFileName, type:type)
        return Utility.splitString(bracketInfoFileContents, separator: "\n")
    }

}
