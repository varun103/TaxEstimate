//
//  TaxBrackets.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/17/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


/// An implementation of linked list which holds all the brackets for a taxType
/// All the brackets are linked starting from the lowest to the highest
class TaxBrackets {
    
    private var head:Bracket?
    private var count: Int
    
    init(){
        self.count = 0
    }
    

    /// Add bracket to the linked List
    ///
    /// - Parameter bracket: bracket to be added
    func add(bracket: Bracket){
        
        if self.head == nil {
            head = bracket
            bracket.setPrevious(previousBracket: nil)
            self.count += 1
        }else{
            var node = head!
            
            while(node.next != nil){
                node = node.next!
            }
            node.setNext(nextBracket: bracket)
            bracket.setPrevious(previousBracket: node)
            self.count += 1
        }
    }
    
    func get(index:Int) throws ->Bracket{
        var _counter = 0
        var node:Bracket

        if index > (self.count + 1) {
            throw AppError.runTimeError
        } else {
            node = self.head!
            while(_counter != index){
                node = node.next!
                _counter += 1
            }
        }
        return node
    }
    
    func isEmpty() -> Bool{
        return self.head == nil
    }
    
    func findBracket(income:Double)-> Bracket{
        return _findBracket(income: income, node: self.head!)
    }
    
    private func _findBracket(income:Double, node:Bracket) -> Bracket{
        if let _max = node.getMax() {
            if (income > _max && node.hasNext() ){
                return _findBracket(income: income, node: node.next!)
            } else {
                return node
            }
        } else {
            return node
        }
    }
    
    func size() -> Int {
        return self.count
    }
    
    
}
