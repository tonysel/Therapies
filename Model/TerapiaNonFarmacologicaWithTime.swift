//
//  TerapiaNonFarmacologicaWithTime.swift
//  Tesi
//
//  Created by TonySellitto on 22/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class TerapiaNonFarmacologicaWithTime {

//    private var codiceTer: Int?
    private var id : String?
    //raccomandazioni e tipoOrario non compaiono poichè sono già presenti in terapiaNonFarmacologica
    private var time: Date?
    private var terapiaNonFarmacologica : TerapiaNonFarmacologica
    private var orario : String?
    private var quando : String?
    private var value : Double?
    
    //le ripetizioni da effettuare con la terapia non farmacologica, se l'orario è libero
    private var ripetizioni : Int?
    
    //nemmeno ultimaModifica è necessaria, poichè non viene calcolato il dosaggio
    //private var ultimaModifica : Date
    
    init(){
        self.terapiaNonFarmacologica = TerapiaNonFarmacologica()
    }
    
    init(terapiaNonFarmacologica: TerapiaNonFarmacologica, time: Date) {
        self.terapiaNonFarmacologica = terapiaNonFarmacologica
        self.time = time
    }
    
    init(terapiaNonFarmacologica: TerapiaNonFarmacologica, orario: String, quando: String) {
        self.terapiaNonFarmacologica = terapiaNonFarmacologica
        self.orario = orario
        self.quando = quando
    }
    
    init(terapiaNonFarmacologica: TerapiaNonFarmacologica){
        self.terapiaNonFarmacologica = terapiaNonFarmacologica
    }
    
    public func createID(){
        self.id = "\(self.terapiaNonFarmacologica.getCodice())-\(String(describing: self.time))"
    }
    
//    public func aggiungiCodiceTerapia(codTer: Int){
//        self.codiceTer = codTer
//    }
    
    public func aggiungiRipetizioni(ripetizioni: Int){
        self.ripetizioni = ripetizioni
    }
    
    public func aggiungiTime(time : Date){
        self.time = time
    }
    
    public func aggiungiOrario(orario : String){
        self.orario = orario
    }
    
    public func aggiungiQuando(quando: String){
        self.quando = quando
    }
    
    public func aggiungiValue(value: Double){
        self.value = value
    }
    
    public func getTerapiaNonFarmacologica() -> TerapiaNonFarmacologica{
        return terapiaNonFarmacologica
    }
    
    public func getId() -> String?{
        return id
    }
    
//    public func getCodiceTerapia() -> Int?{
//        return codiceTer
//    }
    
    public func getRipetizioni() -> Int?{
        return ripetizioni
    }
    
    public func getTime() -> Date?{
        return time
    }
    
    public func getValue() -> Double?{
        return value
    }
    
    public func getOrarioApprossimato() -> String?{
        return orario
    }
    
    public func getQuandoApprossimato() -> String?{
        return quando
    }
}
