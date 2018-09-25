//
//  Medico.swift
//  Tesi
//
//  Created by TonySellitto on 13/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

public class Medico{
    private var codice : String
    private var nome : String
    private var cognome : String
    private var recapitoTelefonico : String
    
    init(){
        self.codice = String()
        self.nome = String()
        self.cognome = String()
        self.recapitoTelefonico = String()
    }
    
    init(codice: String, nome: String, cognome: String, recapitoTelefonico: String){
        self.codice = codice
        self.nome = nome
        self.cognome = cognome
        self.recapitoTelefonico = recapitoTelefonico
    }
    
    public func getCodice() -> String{
        return codice
    }
    public func getCognome() -> String{
        return cognome
    }
    public func getNome() -> String{
        return nome
    }
    public func getRecapitoTelefonico() -> String{
        return recapitoTelefonico
    }
    
    public func setCodice(codice: String){
        self.codice = codice
    }
    
    public func setCognome(cognome: String){
        self.cognome = cognome
    }
    
    public func setNome(nome: String){
        self.nome = nome
    }
    
    public func setRecapitoTelefonico(recapitoTelefonico: String){
        self.recapitoTelefonico = recapitoTelefonico
    }
}
