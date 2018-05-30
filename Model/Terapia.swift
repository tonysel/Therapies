//
//  Terapia.swift
//  Tesi
//
//  Created by TonySellitto on 08/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

public class Terapia {
    var codice : String
    var cadenza : String
    var raccomandazioni : String
    var tipoOrario : String
    var orarioEsatto : [String]!
    var orarioApprossimato : [String: String]!
    var orarioLibero : Int = 0
   // var medicinali : [Medicinale]!
    
    init (codice: String, cadenza: String, raccomandazioni: String, tipoOrario: String) {
        self.codice = codice;
        self.cadenza = cadenza;
        self.raccomandazioni = raccomandazioni;
        self.tipoOrario = tipoOrario;
        self.orarioEsatto = [String]()
        self.orarioApprossimato = [String: String]()
    }
    
    public func aggiungiOrarioEsatto( orario: String) {
        if(orarioEsatto != nil){
            orarioEsatto.removeAll()
        }
        
        orarioEsatto.append(orario)

        
    }
    
    public func aggiungiOrarioApprossimato(tipoOrario: String, quando: String) {
//        if(orarioApprossimato == nil){
//            orarioApprossimato = [String: String]()
//        }
        orarioApprossimato[tipoOrario] = quando
    }
    
    public func aggiungiOrarioLibero(ripetizione : Int) {
        self.orarioLibero = ripetizione
    }
    
//    public func aggiungiMedicinali(medicinale : Medicinale) {
//        self.medicinali.append(medicinale)
//    }
    
    public func getCodice() -> String { return codice }
    public func getCadenza() -> String { return cadenza }
    public func getRaccomandazioni() -> String { return raccomandazioni }
    public func getTipoOrario() -> String{ return tipoOrario }
    public func getOrarioEsatto() -> [String] {
        return orarioEsatto
    }
    public func getOrarioApprossimato() -> [String : String] {
        return orarioApprossimato
    }
    // ricorda che il return è costituito dalle ripetizioni
    public func getOrarioLibero() -> Int{
        return orarioLibero
    }
    
    public func setCodice(codice: String) {
        self.codice = codice
    }
    
    public func setCadenza(cadenza: String) {
        self.cadenza = cadenza
    }
    
    public func setRaccomandazioni(raccomandazioni: String) {
        self.raccomandazioni = raccomandazioni
    }
    
    public func setTipoOrario(tipoOrario: String) {
        self.tipoOrario = tipoOrario
    }
}
