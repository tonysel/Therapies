//
//  TerapiaNonFarmaceutica.swift
//  Tesi
//
//  Created by TonySellitto on 08/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import Foundation

public class TerapiaNonFarmacologica: Terapia {
    private var nome: String
    
    init(){
        self.nome = String()
        super.init(codice: String(), cadenza: String(), raccomandazioni: String(), tipoOrario: String())
    }
    
    init(codice: String, nome: String, cadenza: String, raccomandazioni: String, tipoOrario: String) {
        self.nome = nome
        super.init(codice: codice, cadenza: cadenza, raccomandazioni: raccomandazioni, tipoOrario: tipoOrario)
       
    }

    public func getNome() -> String { return nome}
    
    public func setNome(nome: String){
        self.nome = nome
    }
}

