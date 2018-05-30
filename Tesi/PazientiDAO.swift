//
//  PazientiDAO.swift
//  Tesi
//
//  Created by TonySellitto on 11/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

class PazientiDAO{

    static public func readSpecificPatientQRCode(qrCode: String, completionHandlers:@escaping (Paziente, String, [String], [String])->Void) {
        
        var terapieFarmacologiche = [String]()
        
        var terapieNonFarmacologiche = [String]()
        
        let ref_specific_patient  = Database.database().reference().ref.child("Pazienti").child(qrCode)
        
        ref_specific_patient.observeSingleEvent(of: .value){ (snap) in

            //Fetching node 'Patient' and conversion in Dictionary

            guard let patient_read = snap.value as? NSDictionary else {
                print("Error fetching specific patient")
                return
            }

            //codiceFiscale
            guard let codiceFiscale = patient_read["codice_fiscale"] as? String else{
                print("Error fetching codice fiscale - paziente")
                return
            }
            
            //nome
            guard let nome = patient_read["nome"] as? String else{
                print("Error fetching nome - paziente")
                return
            }
        
            //cognome
            guard let cognome = patient_read["cognome"] as? String else{
                print("Error fetching cognome - paziente")
                return
            }

            //prossimo controllo
            guard let prossimoControllo = patient_read["prossimo_controllo"] as? String else{
                print("Error fetching prossimo controllo - paziente")
                return
            }
            
            //ultima modifica
            guard let ultimaModifica = patient_read["ultima_modifica"] as? Int else{
                print("Error fetching ultima modifica - paziente")
                return
            }
            
            //medico Personale
            guard let medicoPersonale = patient_read["medico"] as? String else{
                print ("Error fecthing hash medico per specifico paziente")
                return
            }
            
            
            
            //terapie farmacologiche correnti
            guard let terapiaFarmacologica = patient_read["terapie_farmacologiche"] as? String else{
                print("Error fetching terapie_farmacologiche")
                return
            }
            
            //terapie non famacologiche correnti
            guard let terapiaNonFarmacologica = patient_read["terapie_non_farmacologiche"] as? String else{
                print("Error fetching terapie_farmacologiche")
                return
            }
            
           terapieFarmacologiche.append(terapiaFarmacologica)
            
           terapieNonFarmacologiche.append(terapiaNonFarmacologica)
            
            let paziente: Paziente = Paziente(codiceFiscale: codiceFiscale, nome: nome, cognome: cognome, prossimoControllo: prossimoControllo, ultimaModifica: ultimaModifica)
            
           
          completionHandlers(paziente, medicoPersonale, terapieFarmacologiche, terapieNonFarmacologiche)
            

        }

    }
    
    
    static public func readCodiceFiscaleFromQRCode(qrCode: String, completionHandlers:@escaping(String) -> Void){
        
        let ref_specific_patient  = Database.database().reference().ref.child("Pazienti").child(qrCode)
        
        ref_specific_patient.observeSingleEvent(of: .value){ (snap) in
            
            //Fetching node 'Patient' and conversion in Dictionary
            
            guard let patient_read = snap.value as? NSDictionary else {
                print("Error fetching specific patient")
                return
            }
            
            //codiceFiscale
            guard let codiceFiscale = patient_read["codice_fiscale"] as? String else{
                print("Error fetching codice fiscale - paziente")
                return
            }
            
            completionHandlers(codiceFiscale)
        }
    }
    
    static public func existsQRCodeOnDB(qrCode: String, completionHandlers:@escaping(Bool) -> Void){
        
        var founded = false
        
        
        
        let ref_patients  = Database.database().reference().ref.child("Pazienti")
        
        ref_patients.observeSingleEvent(of: .value){(snap) in
        
        guard let patients = snap.value as? NSDictionary else {
            print("Error fetching patients")
            return
        }
        
            for patient in patients{
                
                if (patient.key as? String == qrCode){
                    
                    founded = true
//                    //
//                    let ref_specific_patient  = Database.database().reference().ref.child("Pazienti").child(qrCode)
//
//
//                    //Fetching node 'Patient' and conversion in Dictionary
//
//                    guard let patient_read = snap.value as? NSDictionary else {
//                        print("Error fetching specific patient")
//                        return
//                    }
//
//
//                    //codiceFiscale
//                    guard let codiceFiscale = (patient_read["codice_fiscale"] as? String) else{
//                        print("Error fetching codice fiscale patient")
//                        return
//                    }
//
                   
                     break
                }
                
                
            }
            
             completionHandlers(founded)
            
        }
        
        
        
        
    }
    
    static public func aggiungiDiarioTerapieNonFarmacologiche(nomeTerapia: String, risultato: Double, qrCode: String){
        
        let diarioTerapia = [
            
            "nome_terapia" : nomeTerapia,
            "risultato" : risultato
            
            ] as [String : Any]
        
        let ref_diario_terapie =  Database.database().reference().child("Pazienti").child(qrCode).child("diario_terapie_non_farmacologiche")
        
        //add storico terapia on db
        ref_diario_terapie.childByAutoId().setValue(diarioTerapia)
    }
    
}
