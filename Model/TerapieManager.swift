//
//  TerapieManager.swift
//  Tesi
//
//  Created by TonySellitto on 23/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class TerapieManager{

    public static func createTerapieFarmacologicheInWeek(paziente: Paziente) -> [Int: [MedicinaleWithTime]]{
        
        var dictTerFarm = [Int: [MedicinaleWithTime]]()
        //i sette giorni della settimana
        for i in 0...6{
            
            let date = Date(timeIntervalSinceNow: TimeInterval(i * 86400))
            
            var medicinaliWithTime = [MedicinaleWithTime]()
            
            var index = 0

            
            for terapiaFarmacologica in (paziente.getTerapieFarmacologiche()){
                
                let array = TraslationManager.convertStringDateToArrayIntDate(dayInString: (paziente.getTerapieFarmacologiche()[index].getCadenza()))
                
                for medicinale in terapiaFarmacologica.getMedicinali(){
                    
//                    print("CONTROLLA BENISSIMO: \(medicinale.getCodice()) - \(terapiaFarmacologica.getTipoOrario()) - \(array)")
                    
                    if (array.contains(date.getWeekDay(specificDate: date))){
                        
                        if (terapiaFarmacologica.getTipoOrario() == "orario_esatto"){
        
                            //print("ora dizionario: \(times.count)")
                    
                            let times = TraslationManager.convertTimeInStringToDateArray(timeInString: terapiaFarmacologica.getOrarioEsatto()[0])
                            
                            for d in times{
                                
                                let dateFormatter = DateFormatter.init()
                                
                                
                                dateFormatter.dateFormat = "yyyy-MM-dd"
//                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
//                                dateFormatter.string(from: date)
                                //variable d reppresents only HH:mm
                                let dateFormatter2 = DateFormatter.init()
                                dateFormatter2.dateFormat = "HH:mm"
//                                dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")!
//                                dateFormatter2.string(from: d)
                                
                                let dateFormatter3 = DateFormatter.init()
                                dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
//                                dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                let finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) \(dateFormatter2.string(from: d))")
                                
                                let medicinaleWithTime = MedicinaleWithTime(medicinale: medicinale, ultimaModifica: paziente.getUltimaModifica(), tipoOrario: terapiaFarmacologica.getTipoOrario())
                                
                                medicinaleWithTime.aggiungiTime(time: finalTime!)
                                
                                //IMPORTANTE: serve per non far crashare
                                medicinaleWithTime.aggiungiRipetizioni(ripetizioni: 1)
                                
                                //significa che il dosaggio è fisso
                                if medicinaleWithTime.getMedicinale().getDosaggioFisso() != 0{
                                    medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioFisso())
                                }
                                    
                                //significa che il dosaggio è variabile
                                else{
                                    
                                    var days = [Int]()
                                    
                                    for day in (medicinaleWithTime.getMedicinale().getDosaggioVariabile().keys){
                                        days.append(day)
                                        
//                                        print(days)
                                    }
                                    //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                    days.sort()
                                    
                                    var c = 0
                                    
                                    for day in days{
                                        
                                        if c < days.count - 1 {
                                            
                                            
                                            if finalTime!.days(from_date: (medicinaleWithTime.getUltimaModifica())) >= day && finalTime!.days(from_date: (medicinaleWithTime.getUltimaModifica())) < days[c + 1]{
                                                
                                                
                                                medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[day]!)
                                                
                                                break
                                                
                                            }
                                            
                                        }
                                            
                                        else{
                                            
                                            medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[days[c]]!)
                                            
                                        }
                                        
                                        c = c + 1
                                        
                                    }
                                    
                                }
                                
                                if medicinaleWithTime.getDosaggio()! != 0 {
                                    
                                    medicinaleWithTime.aggiungiCodiceTerapia(codTer: terapiaFarmacologica.getCodice())
                                    
                                    medicinaleWithTime.createID()
                                    
                                    medicinaliWithTime.append(medicinaleWithTime)
                                    
                                }
//                                print("ATTENZIONE: \(terapiaFarmacologica.getOrarioApprossimato())")
                            }
                            
                        }
                        
                        if (terapiaFarmacologica.getTipoOrario() == "orario_libero"){
                            
//                            for _ in 1...terapiaFarmacologica.getOrarioLibero(){
                            
                                //print("ora dizionario: \(times.count)")
                                    
                                    let dateFormatter = DateFormatter.init()
                                    
                                    
                                    dateFormatter.dateFormat = "yyyy-MM-dd"
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
                                    //                                dateFormatter.string(from: date)
                                
                                    
                                    let dateFormatter3 = DateFormatter.init()
                                    dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
//                                    dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                    let finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 12:00")
                                    
                                    let medicinaleWithTime = MedicinaleWithTime(medicinale: medicinale, ultimaModifica: paziente.getUltimaModifica(), tipoOrario: terapiaFarmacologica.getTipoOrario())
                                    
                                    medicinaleWithTime.aggiungiTime(time: finalTime!)
                            
                                    //IMPORTANTE: qui aggiungo le ripetizioni visto che l'orario è libero
                                    medicinaleWithTime.aggiungiRipetizioni(ripetizioni: terapiaFarmacologica.getOrarioLibero())
                                    
                                    //significa che il dosaggio è fisso
                                    if medicinaleWithTime.getMedicinale().getDosaggioFisso() != 0{
                                        medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioFisso())
                                    }
                                        
                                        //significa che il dosaggio è variabile
                                    else{
                                        
                                        var days = [Int]()
                                        
                                        for day in (medicinaleWithTime.getMedicinale().getDosaggioVariabile().keys){
                                            days.append(day)
                                            
//                                            print(days)
                                        }
                                        //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                        days.sort()
                                        
                                        var c = 0
                                        
                                        for day in days{
                                            
                                            if c < days.count - 1 {
                                                
                                                
                                                if finalTime!.days(from_date: (medicinaleWithTime.getUltimaModifica())) >= day && finalTime!.days(from_date: (medicinaleWithTime.getUltimaModifica())) < days[c + 1]{
                                                    
                                                    
                                                    medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[day]!)
                                                    
                                                    break
                                                    
                                                }
                                                
                                            }
                                                
                                            else{
                                                
                                                medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[days[c]]!)
                                                
                                            }
                                            
                                            c = c + 1
                                            
                                        }
                                        
                                    }
                                    
                                    if medicinaleWithTime.getDosaggio()! != 0 {
                                        
                                        medicinaleWithTime.aggiungiCodiceTerapia(codTer: terapiaFarmacologica.getCodice())
                                        
                                        medicinaleWithTime.createID()
                                        
                                        medicinaliWithTime.append(medicinaleWithTime)
                                        
                                    }
                    
//                                }
                                
//                                let medicinaleWithTime = MedicinaleWithTime(medicinale: medicinale, ultimaModifica: (paziente.getUltimaModifica()))
//                                medicinaliWithTime.append(medicinaleWithTime)
                            }
                        
                        if (terapiaFarmacologica.getTipoOrario() == "orario_approssimato"){
                            
                            
                            
                            for orario in terapiaFarmacologica.getOrarioApprossimato(){
 
                                let dateFormatter = DateFormatter.init()
                                
                                
                                dateFormatter.dateFormat = "yyyy-MM-dd"
//                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
//                                dateFormatter.string(from: date)
                                
                                
                                let dateFormatter3 = DateFormatter.init()
                                dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
//                                dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                
                                var finalTime = Date()
                                var orarioT = String()
                                var quandoT = String()
                                
                                if orario.key == "colazione"{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 08:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 07:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 09:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                else if orario.key == "pranzo"{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 12:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 11:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 13:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                else{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 20:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 19:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 21:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                
                                let medicinaleWithTime = MedicinaleWithTime(medicinale: medicinale, ultimaModifica: paziente.getUltimaModifica(), tipoOrario: terapiaFarmacologica.getTipoOrario())
                            
                                medicinaleWithTime.aggiungiTime(time: finalTime)
                                
                                medicinaleWithTime.aggiungiOrario(orario: orarioT)
                                
                                medicinaleWithTime.aggiungiQuando(quando: quandoT)
                                
                                //IMPORTANTE: serve per non far crashare
                                medicinaleWithTime.aggiungiRipetizioni(ripetizioni: 1)
                                
                                //significa che il dosaggio è fisso
                                if medicinaleWithTime.getMedicinale().getDosaggioFisso() != 0{
                                    medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioFisso())
                                }
                                    
                                    //significa che il dosaggio è variabile
                                else{
                                    
                                    var days = [Int]()
                                    
                                    for day in (medicinaleWithTime.getMedicinale().getDosaggioVariabile().keys){
                                        days.append(day)
                                        
//                                        print(days)
                                    }
                                    //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                    days.sort()
                                    
                                    var c = 0
                                    
                                    for day in days{
                                        
                                        if c < days.count - 1 {
                                            
//                                            print(finalTime.days(from_date: (medicinaleWithTime.getUltimaModifica())))
                                            
                                            if finalTime.days(from_date: (medicinaleWithTime.getUltimaModifica())) >= day && finalTime.days(from_date: (medicinaleWithTime.getUltimaModifica())) < days[c + 1]{
                                                
                                                
                                                medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[day]!)
                                                
                                                break
                                                
                                            }
                                            
                                        }
                                            
                                        else{
                                            
                                            medicinaleWithTime.aggiungiDosaggio(dosaggio: medicinaleWithTime.getMedicinale().getDosaggioVariabile()[days[c]]!)
                                            
                                        }
                                        
                                        c = c + 1
                                        
                                    }
                                    
                                }
                                
                                if medicinaleWithTime.getDosaggio()! != 0 {
                                    
                                    medicinaleWithTime.aggiungiCodiceTerapia(codTer: terapiaFarmacologica.getCodice())
                                    
                                    medicinaleWithTime.createID()
                                    
                                    medicinaliWithTime.append(medicinaleWithTime)
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
//                print("////////////////////////////////")
                
                index = index + 1
                
            }
            
            dictTerFarm[i] = medicinaliWithTime
            
            medicinaliWithTime.removeAll()
            
        }
        
        return dictTerFarm
        
    }
    
    
    
    public static func createTerapieNonFarmacologicheInWeek(paziente: Paziente) -> [Int : [TerapiaNonFarmacologicaWithTime]]{
        
        var dictTerNonFarm = [Int: [TerapiaNonFarmacologicaWithTime]]()
        //i sette giorni della settimana
        for i in 0...6{
            
            let date = Date(timeIntervalSinceNow: TimeInterval(i * 86400))
            
            var terapieNonFarmacologicheWithTime = [TerapiaNonFarmacologicaWithTime]()
            
            var index = 0
            
            //print("ultima modifica: \(appDelegate?.paziente?.getUltimaModifica())")
            
            for terapiaNonFarmacologica in (paziente.getTerapieNonFarmacologiche()){
                
                let array = TraslationManager.convertStringDateToArrayIntDate(dayInString: (paziente.getTerapieNonFarmacologiche()[index].getCadenza()))

                    if (array.contains(date.getWeekDay(specificDate: date))){
                        
                        if (terapiaNonFarmacologica.getTipoOrario() == "orario_esatto"){
                            
                            //print("ora dizionario: \(times.count)")
                            
                            let times = TraslationManager.convertTimeInStringToDateArray(timeInString: terapiaNonFarmacologica.getOrarioEsatto()[0])
                            
                            for d in times{
                                
                                let dateFormatter = DateFormatter.init()
                                
                                
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                //                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
                                //                                dateFormatter.string(from: date)
                                
                                let dateFormatter2 = DateFormatter.init()
                                dateFormatter2.dateFormat = "HH:mm"
                                //                                dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")!
                                //                                dateFormatter2.string(from: d)
                                
                                let dateFormatter3 = DateFormatter.init()
                                dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
                                //                                dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                let finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) \(dateFormatter2.string(from: d))")
                                
                                let terapiaNonFarmacologicaWithTime = TerapiaNonFarmacologicaWithTime(terapiaNonFarmacologica: terapiaNonFarmacologica)

                                terapiaNonFarmacologicaWithTime.aggiungiTime(time: finalTime!)
                                
                                //IMPORTANTE: serve per non far crashare
                                terapiaNonFarmacologicaWithTime.aggiungiRipetizioni(ripetizioni: 1)
                                
                                terapiaNonFarmacologicaWithTime.createID()
                                    
                                terapieNonFarmacologicheWithTime.append(terapiaNonFarmacologicaWithTime)
                                    
                                }
                            
                            
                        }
                        
                        if (terapiaNonFarmacologica.getTipoOrario() == "orario_libero"){
                            
//                            for _ in 1...terapiaNonFarmacologica.getOrarioLibero(){

                                let dateFormatter = DateFormatter.init()
                                
                                
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                //                                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
                                //                                dateFormatter.string(from: date)
                                
                                
                                let dateFormatter3 = DateFormatter.init()
                                dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
                                //                                    dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                let finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 12:00")
                                
                                let terapiaNonFarmacologicaWithTime = TerapiaNonFarmacologicaWithTime(terapiaNonFarmacologica: terapiaNonFarmacologica)

                                terapiaNonFarmacologicaWithTime.aggiungiTime(time: finalTime!)
                            
                                terapiaNonFarmacologicaWithTime.createID()
                            
                                //IMPORTANTE: qui aggiungo le ripetizioni visto che l'orario è libero
                                terapiaNonFarmacologicaWithTime.aggiungiRipetizioni(ripetizioni: terapiaNonFarmacologica.getOrarioLibero())
                            
                                terapieNonFarmacologicheWithTime.append(terapiaNonFarmacologicaWithTime)
                                    
//                                }
                            
                            }
                        
                        if (terapiaNonFarmacologica.getTipoOrario() == "orario_approssimato"){
                            
                            
                            for orario in terapiaNonFarmacologica.getOrarioApprossimato(){
                                
                                let dateFormatter = DateFormatter.init()
                                
                                
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                //                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
                                //                                dateFormatter.string(from: date)
                                
                                
                                let dateFormatter3 = DateFormatter.init()
                                dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
                                //                                dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")!
                                
                                var finalTime = Date()
                                var orarioT = String()
                                var quandoT = String()
                                
                                if orario.key == "colazione"{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 08:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 07:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 09:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                else if orario.key == "pranzo"{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 12:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 11:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 13:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                else{
                                    if orario.value == "durante"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 20:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else if orario.value == "prima"{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 19:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                    else{
                                        finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: date)) 21:00")!
                                        orarioT = orario.key
                                        quandoT = orario.value
                                    }
                                }
                                
                                let terapiaNonFarmacologicaWithTime = TerapiaNonFarmacologicaWithTime(terapiaNonFarmacologica: terapiaNonFarmacologica)
                                
                                terapiaNonFarmacologicaWithTime.aggiungiTime(time: finalTime)
                                
                                terapiaNonFarmacologicaWithTime.aggiungiOrario(orario: orarioT)
                                
                                terapiaNonFarmacologicaWithTime.aggiungiQuando(quando: quandoT)
                                
                                //IMPORTANTE: serve per non far crashare
                                terapiaNonFarmacologicaWithTime.aggiungiRipetizioni(ripetizioni: 1)
                                
                                terapiaNonFarmacologicaWithTime.createID()
                             
                                terapieNonFarmacologicheWithTime.append(terapiaNonFarmacologicaWithTime)
                              
                                
                            }
                        }
                        
                    }
                
                index = index + 1
                
            }
            
            dictTerNonFarm[i] = terapieNonFarmacologicheWithTime
            
            terapieNonFarmacologicheWithTime.removeAll()
            
        }
        
        return dictTerNonFarm
        
    }

    
}
