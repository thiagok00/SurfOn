//
//  CountriesInput.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 03/11/16.
//
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class CountriesInput {
    
    
    class func inputCountries() {

        let dbRef = FIRDatabase.database().reference().child("countries")
        
        
        
        let data = try! String(contentsOfFile: getPath(), encoding: String.Encoding.iso2022JP)
        
        print(data)
        let strings = (data.components(separatedBy: "\n"))

        var i = 1
        
        while i < strings.count-1 {
        
            let csv = strings[i].components(separatedBy: ",")
            let code = csv[0]
            let englishName = csv[1]
            
            print("*"+code+"* *"+englishName+"+")
            
            let ref = dbRef.child(code)
            ref.setValue(englishName)
            i = i + 1
        }
    }
    
        class func getPath()->String {
            
            let rootPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            let plistPath = rootPath.appending("/countries.csv")
            let fileManager: FileManager = FileManager.default
            
            if !fileManager.fileExists(atPath: plistPath) {
                
                let bundlePath: String? = Bundle.main.path(forResource: "countries", ofType: "csv")
                
                if let bundle = bundlePath {
                    do {
                        try fileManager.copyItem(atPath: bundle, toPath: plistPath)
                    }
                    catch let error as NSError {
                        print("Erro ao copiar Materias.plist do mainBundle para plistPath: \(error.description)")
                    }
                }
                else {
                    print("Materias.plist não está no mainBundle")
                }
            }
            return plistPath
        }
        
    
    
    
    class func inputCidades() {
    
        let dbRef = FIRDatabase.database().reference().child("cities")
    
        let ref = dbRef.ref.childByAutoId()
        ref.setValue(["name":"Rio de janeiro", "country_id":"BR"])
        let ref2 = dbRef.ref.childByAutoId()
        ref2.setValue(["name":"Bahia", "country_id":"BR"])
        inputPraias(f: ref, f2: ref2)
    }
    
    class func inputPraias(f:FIRDatabaseReference, f2:FIRDatabaseReference) {
    
        let dbRef = FIRDatabase.database().reference().child("beaches")
        
        dbRef.ref.childByAutoId().setValue(["name":"Arpoador", "city_id":f.key])
        dbRef.ref.childByAutoId().setValue(["name":"Copacabana", "city_id":f.key])
        dbRef.ref.childByAutoId().setValue(["name":"Praia do Forte", "city_id":f2.key])
        dbRef.ref.childByAutoId().setValue(["name":"Praia da Bahia", "city_id":f2.key])

        
        
    }
    
    
    
}
