//
//  MedicinaleWithTime.swift
//  Tesi
//
//  Created by TonySellitto on 20/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class MedicinaleWithTime{

//    private var codiceMed : Int?
    private var codiceTer : String?
    private var id : String?
    private var tipoOrario : String
    private var raccomandazioni: String?
    private var time: Date?
    private var medicinale: Medicinale
    private var orario : String?
    private var quando : String?
    //IMPORTANTE ... contiente il dosaggio a quall'effettivo time, andando oltre al dosaggio fisso o variabile del medicinale
    private var dosaggio : Double?
    
    private var ultimaModifica : Date
    //le ripetizioni da effettuare con il medicinale , se l'orario è libero
    private var ripetizioni : Int?
    
//    init(medicinale: Medicinale, time: Date, ultimaModifica: Date) {
//        self.medicinale = medicinale
//        self.time = time
//        self.ultimaModifica = ultimaModifica
//    }
    
    init(){
        self.medicinale = Medicinale()
        self.ultimaModifica = Date()
        self.tipoOrario = String()
    }
    
    init(medicinale: Medicinale, ultimaModifica: Date, tipoOrario: String) {
        self.medicinale = medicinale
        self.ultimaModifica = ultimaModifica
        self.tipoOrario = tipoOrario
    }
    
    init(medicinale: Medicinale, orario: String, quando: String, ultimaModifica: Date, tipoOrario: String) {
        self.medicinale = medicinale
        self.orario = orario
        self.quando = quando
        self.ultimaModifica = ultimaModifica
        self.tipoOrario = tipoOrario
    }
    
    public func createID(){
        self.id = "\(self.codiceTer ?? "nil")-\(self.medicinale.getCodice())-\(self.time ?? Date())"
    }
    
//    public func aggiungiCodiceMedicina(codMed: Int){
//        self.codiceMed = codMed
//    }
    
    public func aggiungiCodiceTerapia(codTer: String){
        self.codiceTer = codTer
    }
    
    public func aggiungiRipetizioni(ripetizioni: Int){
        self.ripetizioni = ripetizioni
    }
    
    public func aggiungiMedicinale(medicinale: Medicinale){
        self.medicinale = medicinale
    }
    
    public func aggiungiUltimaModifica(ultimaModifica: Date){
        self.ultimaModifica = ultimaModifica
    }
    
    public func aggiungiTipoOrario(tipoOrario: String){
        self.tipoOrario = tipoOrario
    }
    
    public func aggiungiTime(time : Date){
        self.time = time
    }
    
    public func aggiungiDosaggio(dosaggio: Double){
        self.dosaggio = dosaggio
    }
    
    public func aggiungiOrario(orario : String){
        self.orario = orario
    }
    
    public func aggiungiQuando(quando: String){
        self.quando = quando
    }
    
    public func aggiungiRaccomandazioni(raccomandazioni: String){
        self.raccomandazioni = raccomandazioni
    }
    
    public func getMedicinale() -> Medicinale{
        return medicinale
    }
    
    public func getId() -> String?{
        return id
    }
    
//    public func getCodiceMedicina() -> Int?{
//        return codiceMed
//    }
    
    public func getCodiceTerapia() -> String?{
        return codiceTer
    }
    
    public func getRipetizioni() -> Int?{
        return ripetizioni
    }
    
    public func getRaccomandazioni() -> String?{
        return raccomandazioni
    }
    
    public func getTime() -> Date?{
        return time
    }
    
    public func getOrarioApprossimato() -> String?{
        return orario
    }
   
    public func getQuandoApprossimato() -> String?{
        return quando
    }
    
    public func getDosaggio() -> Double?{
        return dosaggio
    }
    
    public func getUltimaModifica() -> Date{
        return ultimaModifica
    }
    
    public func getTipoOrario() -> String{
        return tipoOrario
    }
}
