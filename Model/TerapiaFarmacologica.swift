//
//  TerapiaFarmaceutica.swift
//  Tesi
//
//  Created by TonySellitto on 08/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import Foundation

public class TerapiaFarmacologica: Terapia {
    private var medicinals : [Medicinale]!
    
    override init(codice: String, cadenza: String, raccomandazioni: String, tipoOrario: String) {
        self.medicinals = [Medicinale]()
        super.init(codice: codice, cadenza: cadenza, raccomandazioni: raccomandazioni, tipoOrario: tipoOrario)
        
    }
    
    public func aggiungiMedicinale(medicinale: Medicinale) -> Void { medicinals.append(medicinale) }
    
    public func getMedicinali() -> [Medicinale] { return medicinals }
}
