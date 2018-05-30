//
//  MediciDAO.swift
//  Tesi
//
//  Created by TonySellitto on 12/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

class MediciDAO{

    static public func readSpecificMedico(codiceMedico: String, completionHandlers:@escaping (Medico)->Void) {
        
        let ref_specific_patient  = Database.database().reference().ref.child("Medici").child(codiceMedico)
        
        ref_specific_patient.observeSingleEvent(of: .value){ (snap) in
            
            //Fetching node 'Patient' and conversion in Dictionary
            
            guard let patient_read = snap.value as? NSDictionary else {
                print("Error fetching specific medico")
                return
            }
            
            //nome
            guard let nome = patient_read["nome"] as? String else{
                print("Error fetching nome medico")
                return
            }
            
            //cognome
            guard let cognome = patient_read["cognome"] as? String else{
                print("Error fetching cognome medico")
                return
            }
            
            
            //recapito telefonico
            guard let recapitoTelefonico = patient_read["telefono"] as? String else{
                print("Error fetching telefono medico")
                return
            }
            
            
            //inizializzazione medico
            let medico = Medico(codice: codiceMedico, nome: nome, cognome: cognome, recapitoTelefonico: recapitoTelefonico)
//
           
            completionHandlers(medico)
        }
        
    }
    
    static public func aggiungiRichiestaAiuto(medico: Medico, codice: String, nota: String){
      
            //Conversione di una richesta di aiuto al medico in dictionary
        let visualizzata : Int = 0
            let richiestaAiuto_to_add = [
                
                "nota" : nota,
                "visualizzata" : visualizzata
                
                ] as [String : Any]
            
            let ref_richieste_aiuto =  Database.database().reference().child("Medici").child(medico.getCodice()).child("richieste_assistenza")
    
        //add richiesta di aiuto on db
        ref_richieste_aiuto.child(codice).setValue(richiestaAiuto_to_add)
    }
    

}
