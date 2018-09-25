//
//  Medico.swift
//  Tesi
//
//  Created by TonySellitto on 28/04/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

public class Medicinale{
    
    private var nome: String
    private var codice : String
    private var misuraDosaggio : String
    private var imageUrl : String
    private var dosaggioFisso : Double
    private var dosaggioVariabile : [Int : Double]!
    
    init(){
        self.nome = String()
        self.codice = String()
        self.misuraDosaggio = String()
        self.imageUrl = String()
        self.dosaggioFisso = Double()
        self.dosaggioVariabile = [Int : Double]()
    }
    
    init(nome : String, codice: String, imageUrl: String, misuraDosaggio: String, dosaggioFisso: Double) {
    self.nome = nome
    self.codice = codice
    self.imageUrl = imageUrl
    self.misuraDosaggio = misuraDosaggio
    self.dosaggioFisso = dosaggioFisso
    self.dosaggioVariabile = Dictionary<Int, Double>()
    }
    
    public func aggiungiDosaggioVariabile(giornoCambiamento : Int, dosaggio: Double) {
//        if(dosaggioVariabile.isEmpty){
//            dosaggioVariabile = Dictionary<Int, Double>()
//            dosaggioFisso = 0;
        
        dosaggioVariabile[giornoCambiamento] = dosaggio
        
//    }
    }
    public func getNome() -> String{ return nome }
    public func getCodice() -> String { return codice }
    public func getImageUrl()  -> String { return imageUrl}
    public func getMisuraDosaggio() -> String { return misuraDosaggio }
    public func getDosaggioFisso() -> Double { return dosaggioFisso}
    public func getDosaggioVariabile() -> Dictionary<Int, Double> { return dosaggioVariabile }
    
    public func setNome(nome: String) {
    self.nome = nome
    }
    
    public func setCodice(codice: String) {
    self.codice = codice
    }
    
    public func setImageUrl(imageUrl: String) {
    self.imageUrl = imageUrl
    }
    
    public func setMisuraDosaggio(misuraDosaggio: String) {
    self.misuraDosaggio = misuraDosaggio
    }
    
    public func setDosaggioFisso(dosaggioFisso: Double) {
    self.dosaggioFisso = dosaggioFisso
    }
}

