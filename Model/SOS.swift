//
//  SOS.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class SOS{

    public var time: Date
    private var nota: String
    private var visualizzata: Int
    
    init(time: Date, nota: String, visualizzata: Int){
        self.time = time
        self.nota = nota
        self.visualizzata = visualizzata
    }

    public func getTime() -> Date{
        return time
    }
    
    public func getNota() -> String{
        return nota
    }
    
    public func getVisualizzata() -> Int{
        return visualizzata
    }
}
