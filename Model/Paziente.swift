//
//  Paziente.swift
//  Tesi
//
//  Created by TonySellitto on 11/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class Paziente {
   
    private var codiceFiscale : String
    private var nome : String
    private var cognome : String
    private var prossimoControllo : Date
    private var ultimaModifica : Date
    private var terapieFarmacologiche : [TerapiaFarmacologica]
    private var terapieNonFarmacologiche : [TerapiaNonFarmacologica]
    private var medicoControllo : Medico
    
    init(codiceFiscale : String, nome: String, cognome: String, prossimoControllo: String,
         ultimaModifica: Int) {
        
        self.codiceFiscale = codiceFiscale
        self.nome = nome;
        self.cognome = cognome;
        do{
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.prossimoControllo = dateFormatter.date(from: prossimoControllo)!
            print(prossimoControllo)
        }
       //CONTROLLARE BENE PERCHè NON SI CAPISCE COSA FACCIA
        self.ultimaModifica = Date(timeIntervalSince1970: TimeInterval(ultimaModifica))
        self.terapieFarmacologiche = [TerapiaFarmacologica]()
        self.terapieNonFarmacologiche = [TerapiaNonFarmacologica]()
        self.medicoControllo = Medico()
        }
    
        
    public func aggiungiTerapiaFarmacologica(terapia: TerapiaFarmacologica) {
        terapieFarmacologiche.append(terapia)
    }
    
    public func aggiungiTerapieFarmacologiche(terapie: [TerapiaFarmacologica]) {
        terapieFarmacologiche = terapie
    }

    public func aggiungiTerapieNonFarmacologiche(terapie: [TerapiaNonFarmacologica]) {
        terapieNonFarmacologiche = terapie
    }
    
    public func aggiungiTerapiaNonFarmacologica(terapia: TerapiaNonFarmacologica ) {
        terapieNonFarmacologiche.append(terapia)
    }
    
    public func aggiungiMedicoControllo(medicoC: Medico){
        self.medicoControllo = medicoC
    }
    
    public func getMedicoControllo() -> Medico { return medicoControllo }
        public func getCodiceFiscale() -> String { return codiceFiscale }
        public func getNome() -> String { return nome }
        public func getCognome() -> String { return cognome }
        public func getProssimoControllo() -> Date { return prossimoControllo }
        public func getUltimaModifica() -> Date { return ultimaModifica }
        public func getTerapieFarmacologiche() -> [TerapiaFarmacologica] {
            return terapieFarmacologiche
        }
        public func getTerapieNonFarmacologiche() -> [TerapiaNonFarmacologica] {
            return terapieNonFarmacologiche
        }
        
        public func setCodiceFiscale(codiceFiscale: String) {
            self.codiceFiscale = codiceFiscale
        }
        
        public func setNome(nome: String) {
            self.nome = nome
        }
        
        public func setCognome(cognome: String) {
            self.cognome = cognome
        }
        
        public func setProssimoControllo(prossimoControllo: Date) {
            self.prossimoControllo = prossimoControllo;
        }
        
        public func setUltimaModifica(ultimaModifica: Date) {
            self.ultimaModifica = ultimaModifica
        }
    
    }

 

