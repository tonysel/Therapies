//
//  TherapyDAO.swift
//  Tesi
//
//  Created by TonySellitto on 08/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseCore

class FBManager{
    
    var delegate: FBManagerDelegate?
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //TERAPIA 1
    public func readSpecificTherapieFarmacologiche(codiciTerapie: [String], completionHandlers:@escaping ([TerapiaFarmacologica])->Void) {
    
        var finalTerapieFarmacologiche = [TerapiaFarmacologica]()
        
        for i in 1...codiciTerapie.count{
            
            let ref_specific_therapy  = Database.database().reference().ref.child("TerapieFarmacologiche").child(codiciTerapie[i - 1])
            
            ref_specific_therapy.observeSingleEvent(of: .value){ (snap) in
                
                
                //Fetching node 'Therapy' and conversion in Dictionary
                guard let therapy_read = snap.value as? NSDictionary else {
                    print("Error fetching specific therapy")
                    return
                }
                
                //cadenza
                guard let cadenza = (therapy_read["cadenza"] as? String) else {
                    print("Error fetching cadenza")
                    return
                }
                
                //orario_aggiunta
                guard let orario_aggiunta = (therapy_read["orario_aggiunta"] as? Int) else {
                    print("Error fetching name")
                    return
                }
                
                //raccomandazioni
                guard let raccomandazioni = (therapy_read["raccomandazioni"] as? String) else {
                    print("Error fetching raccomandazioni")
                    return
                }
                
                //tipo_orario
                guard let tipo_orario = (therapy_read["tipo_orario"] as? String) else {
                    print("Error fetching tipo_orario")
                    return
                }
                
                //dictionary medicinali
                guard let medicinali = (therapy_read["medicinali"] as? NSDictionary) else {
                    print("Error fetching Medicinali")
                    return
                }
                
                let terapiaFarmacologica: TerapiaFarmacologica = TerapiaFarmacologica(codice: codiciTerapie[i - 1], cadenza: cadenza, raccomandazioni: raccomandazioni, tipoOrario: tipo_orario)
                
                
                //esecuzione tramite specificazione tipo_orario
                if (tipo_orario == "orario_approssimato"){
                    //orario_approssimato
                    guard let orario_approssimato = (therapy_read["orario_approssimato"] as? NSDictionary) else {
                        print("Error fetching orario_approssimato - terapia non farmacologica")
                        return
                    }
                    for pasto in orario_approssimato {
                        terapiaFarmacologica.aggiungiOrarioApprossimato(tipoOrario: pasto.key as! String, quando: pasto.value as! String)
                    }
                }
                else if (tipo_orario == "orario_esatto"){
                    //orario_esatto
                    guard let orario_esatto = (therapy_read["orario_esatto"] as? String) else {
                        print("Error fetching orario_esatto - terapia non farmacologica")
                        return
                    }
                    
                    terapiaFarmacologica.aggiungiOrarioEsatto(orario: orario_esatto)
                }
                    //quindi il tipo_orario è libero
                else{
                    //orario_libero
                    guard let ripetizioni = (therapy_read["ripetizione_orario_libero"] as? String) else {
                        print("Error fetching ripetizione_orario_libero - terapia non farmacologica")
                        return
                    }
                    
                    terapiaFarmacologica.aggiungiOrarioLibero(ripetizione: Int(ripetizioni)!)
                    
                }
                
                
                for medicinale in medicinali{
                    
                    //codice medicinale
                    guard let codiceMedicinale = medicinale.key as? String else{
                        print("Error fetching codice medicinale")
                        return
                    }
                    
                    //prendo il dizionario dato dal value del medinale
                    guard let datiMedicinale = medicinale.value as? NSDictionary else{
                        print("Error fetching dictionary value medicinale")
                        return
                    }
                    
                    //nome medicinale
                    guard let nomeMedicinale = datiMedicinale["nome_medicinale"] as? String else{
                        print("Error fetching nome medicinale")
                        return
                    }
                    
                    //misura dosaggio medicinale
                    guard let misuraDosaggioMedicinale = datiMedicinale["misura_dosaggio"] as? String else{
                        print("Error fetching misura dosaggio medicinale")
                        return
                    }
                    
                    //dose fissa medicinale
                    guard let doseFissa = datiMedicinale["dose_fissa"] as? String else{
                        print("Error fetching dose fissa medicinale")
                        return
                    }
                    
                    //inizializzo medicinale senza aggiungere un'eventuale dose variabile
                    let medicine = Medicinale(nome: nomeMedicinale, codice: codiceMedicinale, imageUrl: nomeMedicinale, misuraDosaggio: misuraDosaggioMedicinale, dosaggioFisso: Double(doseFissa)!)
                    
                    terapiaFarmacologica.aggiungiMedicinale(medicinale: medicine)
                    
                    if (doseFissa == "0"){
                        //dose variabile
                        guard let doseVariabile = datiMedicinale["dosaggio_variabile"] as? NSDictionary else{
                            print("Error fetching dose variabile medicinale")
                            return
                        }
                        
                        for doseSingola in doseVariabile{
                            
                            //giorno in bui assumere una determinata dose
                            guard let giornoDoseVariabile = doseSingola.key as? String else{
                                print("Error fetching giorno dose variabile medicinale")
                                return
                            }
                            
                            //value che contiene la dose da assumere per il determinato giorno
                            guard let datiDoseVariabilePerGiorno = doseSingola.value as? NSDictionary else{
                                print("Error fetching dictionary dose vabile for day - medicinale")
                                return
                            }
                            
                            //q.tà dose variabile per determinato giorno
                            guard let qtaDoseVariabile = datiDoseVariabilePerGiorno["dose"] as? String else{
                                print("Error fetching q.tà dose varibile - medicinale")
                                return
                            }
                            //print("dose variabile: \(giornoDoseVariabile):\(qtaDoseVariabile)")
                            //aggiunge dose variabile
                            //RICORDATI BENE I CAST DI INT E DOUBLE XKE' POTRESTI AVERE PROBLEMI
                            medicine.aggiungiDosaggioVariabile(giornoCambiamento: Int(giornoDoseVariabile)!, dosaggio: Double(qtaDoseVariabile)!)
                            
                        }
                        
                    }
                    
                }
                
                
                finalTerapieFarmacologiche.append(terapiaFarmacologica)
                
                //self.delegate.onSuccess()
                
                if i == codiciTerapie.count{
                    
                    completionHandlers(finalTerapieFarmacologiche)
                    
                }
                
            }
            
            
        }
        
        
        
    }
    
    
    //TERAPIA 2
    public func readSpecificTherapieNonFarmacologiche(codiciTerapie: [String], completionHandlers:@escaping ([TerapiaNonFarmacologica])->Void) {
        
        var finalTerapieNonFarmacologiche = [TerapiaNonFarmacologica]()
        
        for i in 1...codiciTerapie.count{
            
            let ref_specific_therapy  = Database.database().reference().ref.child("TerapieNonFarmacologiche").child(codiciTerapie[i - 1])
            
            ref_specific_therapy.observeSingleEvent(of: .value){ (snap) in
                
                //Fetching node 'Therapy' and conversion in Dictionary
                guard let therapy_read = snap.value as? NSDictionary else {
                    print("Error fetching specific therapy")
                    
                    return
                }
                
                //nome
                guard let nome = (therapy_read["nome"] as? String) else {
                    print("Error fetching cadenza")
                    return
                }
                
                //cadenza
                guard let cadenza = (therapy_read["cadenza"] as? String) else {
                    print("Error fetching cadenza")
                    return
                }
                
                //orario_aggiunta
                guard let orario_aggiunta = (therapy_read["orario_aggiunta"] as? Int) else {
                    print("Error fetching name")
                    return
                }
                
                //raccomandazioni
                guard let raccomandazioni = (therapy_read["raccomandazioni"] as? String) else {
                    print("Error fetching raccomandazioni")
                    return
                }
                
                //tipo_orario
                guard let tipo_orario = (therapy_read["tipo_orario"] as? String) else {
                    print("Error fetching tipo_orario")
                    return
                }
                
                let terapiaNonFarmacologica = TerapiaNonFarmacologica(codice: codiciTerapie[i - 1], nome: nome, cadenza: cadenza, raccomandazioni: raccomandazioni, tipoOrario: tipo_orario)
                
                
                //esecuzione tramite specificazione tipo_orario
                if (tipo_orario == "orario_approssimato"){
                    //orario_esatto
                    guard let orario_approssimato = (therapy_read["orario_approssimato"] as? NSDictionary) else {
                        print("Error fetching orario_approssimato - terapia non farmacologica")
                        return
                    }
                    for pasto in orario_approssimato {
                        terapiaNonFarmacologica.aggiungiOrarioApprossimato(tipoOrario: pasto.key as! String, quando: pasto.value as! String)
                    }
                }
                else if (tipo_orario == "orario_esatto"){
                    //orario_esatto
                    guard let orario_esatto = (therapy_read["orario_esatto"] as? String) else {
                        print("Error fetching orario_esatto - terapia non farmacologica")
                        return
                    }
                    
                    terapiaNonFarmacologica.aggiungiOrarioEsatto(orario: orario_esatto)
                }
                    //quindi il tipo_orario è libero
                else{
                    //orario_esatto
                    guard let ripetizioni = (therapy_read["ripetizione_orario_libero"] as? String) else {
                        print("Error fetching ripetizione_orario_libero - terapia non farmacologica")
                        return
                    }
                    
                    terapiaNonFarmacologica.aggiungiOrarioLibero(ripetizione: Int(ripetizioni)!)
                    
                }
                
                finalTerapieNonFarmacologiche.append(terapiaNonFarmacologica)
                
                if i == codiciTerapie.count{
                    completionHandlers(finalTerapieNonFarmacologiche)
                }
                
                
                //self.delegate.onSuccess()
                
            }
            
        }
        
    }
    
    
    //PATIENT 1
    public func readSpecificPatientQRCode(qrCode: String, completionHandlers:@escaping (Paziente, String, [String], [String])->Void) {
        
        var terapieFarmacologiche = [String]()
        
        var terapieNonFarmacologiche = [String]()
        
        let ref_specific_patient  = Database.database().reference().ref.child("Pazienti").child(qrCode)
        
        ref_specific_patient.observeSingleEvent(of: .value){ (snap) in
            //inizio closure
            
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
            
            
            
            let delimiter = ";"
            
            terapieFarmacologiche = terapiaFarmacologica.components(separatedBy: delimiter)
            
            terapieNonFarmacologiche = terapiaNonFarmacologica.components(separatedBy: delimiter)
            
            //          TraslationManager.convertTherapiesInStringToStringArray(therapiesInString: terapiaNonFarmacologica)
            
            let paziente: Paziente = Paziente(codiceFiscale: codiceFiscale, nome: nome, cognome: cognome, prossimoControllo: prossimoControllo, ultimaModifica: ultimaModifica)
            
            
            completionHandlers(paziente, medicoPersonale, terapieFarmacologiche, terapieNonFarmacologiche)
            
            
        }
        
    }
    
    //PATIENT 2
    public func readCodiceFiscaleFromQRCode(qrCode: String, completionHandlers:@escaping(String) -> Void){
        
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
    
    //PATIENT 3
    public func existsQRCodeOnDB(qrCode: String, completionHandlers:@escaping(Bool) -> Void){
        
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
                    
                    break
                }
                
                
            }
            
            completionHandlers(founded)
            
        }
        
    }
    
    //PATIENT 4
    public func aggiungiDiarioTerapieNonFarmacologiche(nomeTerapia: String, risultato: Double, qrCode: String){
        
        let diarioTerapia = [
            
            "nome_terapia" : nomeTerapia,
            "risultato" : risultato
            
            ] as [String : Any]
        
        guard  (appDelegate?.isInternetAvailable())! else{
            self.delegate?.onFailure()
            return
        }
        
        let ref_diario_terapie =  Database.database().reference().child("Pazienti").child(qrCode).child("diario_terapie_non_farmacologiche")
        
        let date = Date()
        //conversion of date in timeInterval (Double) and after in Int
        let ultimaModificaInt = Int(date.timeIntervalSince1970)
        //add storico terapia on db
        ref_diario_terapie.child(String(ultimaModificaInt)).setValue(diarioTerapia)
        
        self.delegate?.onSuccess()
    }
    
    //MEDICO 1
    public func readSpecificMedico(codiceMedico: String, completionHandlers:@escaping (Medico)->Void) {
        
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
    
    //MEDICO 2
    public func aggiungiRichiestaAiuto(medico: Medico, codice: String, nota: String){
        
        //Conversione di una richesta di aiuto al medico in dictionary
        let visualizzata : Int = 0
        let richiestaAiuto_to_add = [
            
            "nota" : nota,
            "visualizzata" : visualizzata
            
            ] as [String : Any]
        
//        guard  (appDelegate?.isInternetAvailable())! else{
//            self.delegate?.onFailure()
//            return
//        }
        
        let ref_richieste_aiuto =  Database.database().reference().child("Medici").child(medico.getCodice()).child("richieste_assistenza")
        
        let date = Date()
        //conversion of date in timeInterval (Double) and after in Int
        let ultimaModificaInt = Int(date.timeIntervalSince1970)
        
        //add richiesta di aiuto on db
        ref_richieste_aiuto.child("\(String(ultimaModificaInt))-\(codice)").setValue(richiestaAiuto_to_add)
        
        self.delegate?.onSuccess()
    }
    
    //MEDICO 2.5 RIMUOVI RICHIESTA
    public func rimuoviRichiestaAiuto(medico: Medico, codice: String, date: Date, completionHandlers:@escaping ()->Void){
        
        let ref_richieste_aiuto =  Database.database().reference().child("Medici").child(medico.getCodice()).child("richieste_assistenza")
        
        //add richiesta di aiuto on db
        ref_richieste_aiuto.child("\(String(Int(date.timeIntervalSince1970)))-\(codice)").removeValue()
    
        completionHandlers()
    }
    
    //MEDICO 3
    public func readRichiesteAiuto(medico: Medico, codice: String, completionHandlers:@escaping ([SOS])->Void){
        
        var soss = [SOS]()
        
        let ref_richieste_aiuto =  Database.database().reference().child("Medici").child(medico.getCodice()).child("richieste_assistenza")
        
        ref_richieste_aiuto.observeSingleEvent(of: .value){(snap) in
            
            guard let helps = snap.value as? NSDictionary else {
                print("Error fetching Helps")
                return
            }
            
            for help in helps{
                
                guard let codiceHelp = help.key as? String else {
                    print("Error fetching codice help from medico")
                    return
                }
                
                let delimiter = "-"
                
                let informations = codiceHelp.components(separatedBy: delimiter)
                
                if informations[1] == codice{
                    
                    guard let valueHelp = help.value as? NSDictionary else {
                        print("Error fetching value help from medico")
                        return
                    }
                    
                    var notaHelp : String?
                    
                    var visualizzataHelp : Int?
                    
                    for (key, value) in valueHelp{
                        
                        if key as! String == "nota"{
                            notaHelp = value as? String
                        }
                        
                        if key as! String == "visualizzata"{
                            visualizzataHelp = value as? Int
                        }
                        
                    }
                    
                    let sos = SOS(time: Date(timeIntervalSince1970: TimeInterval(Int(informations[0])!)), nota: notaHelp!, visualizzata: visualizzataHelp!)
                    
                    soss.append(sos)
                }
                
            }
            
            completionHandlers(soss)
        }
        
    }
    
    //Uodate Local informations
    public func updateDB(codicePaziente: String, ultimaModificaPiano: Date){
        
        let ref_patient =  Database.database().reference().child("Pazienti").child(codicePaziente)
        
        ref_patient.observeSingleEvent(of: .value){ (snap) in
            
            //Fetching node 'Patient' and conversion in Dictionary
            
            guard let patient_read = snap.value as? NSDictionary else {
                print("Error fetching specific patient for update")
                return
            }
            
            //ultima modifica
            guard let ultimaModifica = patient_read["ultima_modifica"] as? Int else{
                print("Error fetching ultima_modifica paziente update")
                return
            }
            
            let ultimaModicaReveived = Date(timeIntervalSince1970: TimeInterval(ultimaModifica))
            
//            print("1:  \(ultimaModificaPiano)")
//            print("2:  \(ultimaModicaReveived)")
        
            if ultimaModificaPiano.compare(ultimaModicaReveived) != .orderedSame{
                self.savePaziente(qrCode: codicePaziente)
            }
            else{
                print("It's not necessary update for this patient")
                self.delegate?.onSuccess()
            }
            
        }
        
    }
    
    
    //PROVA PAZIENTE
    
    public func savePaziente(qrCode: String){
        CoreDataController.shared.deleteAllPazienti()
        CoreDataController.shared.deleteAllImages()
        CoreDataController.shared.deleteAllMedicine()
        CoreDataController.shared.deleteAllMedici()
        CoreDataController.shared.deleteAllTerapieFarmacologiche()
        CoreDataController.shared.deleteAllTerapieNonFarmacologiche()
        
        
        self.readSpecificPatientQRCode(qrCode: qrCode){(paziente, codiceMedicoPersonale, terapieFarmacologiche, terapieNonFarmacologiche) in
            
            self.readSpecificMedico(codiceMedico: codiceMedicoPersonale){(medico) in
                
                paziente.aggiungiMedicoControllo(medicoC: medico)
                
                self.readSpecificTherapieFarmacologiche(codiciTerapie: terapieFarmacologiche){(terapieFarm) in
                    
                    self.readSpecificTherapieNonFarmacologiche(codiciTerapie: terapieNonFarmacologiche){(terapieNonFarm) in
                        
                        //IMPORTANTE
                        paziente.aggiungiTerapieFarmacologiche(terapie: terapieFarm)
                        
                        for i in 1...paziente.getTerapieFarmacologiche().count{
                            
                            print("CODICE TERAPIA FARM \(i): \(paziente.getTerapieFarmacologiche()[i-1].getCodice())")
                            
                        }
                        
                        paziente.aggiungiTerapieNonFarmacologiche(terapie: terapieNonFarm)
                        
                        for i in 1...paziente.getTerapieNonFarmacologiche().count{
                            print("CODICE TERAPIA NON FARM \(i): \(paziente.getTerapieNonFarmacologiche()[i-1].getCodice())")
                            
                        }
                        
                        //HO FINITO DI SCARICARE DA FIREBASE
                        
                        CoreDataController.shared.aggiungiPaziente(paziente: paziente, terapieFarmacologiche: terapieFarm, terapieNonFarmacologiche: terapieNonFarm, medicoControllo: medico)
                        
                        self.appDelegate?.paziente = paziente
                        
                        self.delegate?.onSuccess()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

protocol FBManagerDelegate {
    func onSuccess()
    func onFailure()
}
