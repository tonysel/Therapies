//
//  CoreDataController.swift
//  Tesi
//
//  Created by TonySellitto on 14/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataController{

    static let shared = CoreDataController()
        
    let context : NSManagedObjectContext
    
    var delegate: CoreDataControllerDelegate?
        
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func aggiungiMedicinaleWithTime(medicineWithTime: MedicinaleWithTime){
        let entity = NSEntityDescription.entity(forEntityName: "MedicinaleWithTimeCore", in: self.context)
        
        let medicinaleWithTimeCore = MedicinaleWithTimeCore(entity: entity!, insertInto: context)
    
        medicinaleWithTimeCore.id = medicineWithTime.getId()
        medicinaleWithTimeCore.misuraDosaggio = medicineWithTime.getMedicinale().getMisuraDosaggio()
        medicinaleWithTimeCore.tipoOrario = medicineWithTime.getTipoOrario()
        medicinaleWithTimeCore.raccomandazioni = medicineWithTime.getRaccomandazioni()
        medicinaleWithTimeCore.nome = medicineWithTime.getMedicinale().getNome()
        medicinaleWithTimeCore.time = medicineWithTime.getTime()! as NSDate
        medicinaleWithTimeCore.orario = medicineWithTime.getOrarioApprossimato()
        medicinaleWithTimeCore.quando = medicineWithTime.getQuandoApprossimato()
        medicinaleWithTimeCore.ultimaModifica = medicineWithTime.getUltimaModifica() as NSDate
        medicinaleWithTimeCore.dosaggio = medicineWithTime.getDosaggio()!
        medicinaleWithTimeCore.codiceMed = medicineWithTime.getMedicinale().getCodice()
        medicinaleWithTimeCore.codiceTer = medicineWithTime.getCodiceTerapia()
        medicinaleWithTimeCore.ripetizioni = 1
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio MedicinaleWithTimeCore: \(medicinaleWithTimeCore.id!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    func aggiungiMedicinaleWithTimeWithAddRipetizione(medicineWithTime: MedicinaleWithTime, addRipetizione: Int){
        let entity = NSEntityDescription.entity(forEntityName: "MedicinaleWithTimeCore", in: self.context)
        
        let medicinaleWithTimeCore = MedicinaleWithTimeCore(entity: entity!, insertInto: context)
        
        medicinaleWithTimeCore.id = medicineWithTime.getId()
        medicinaleWithTimeCore.tipoOrario = medicineWithTime.getTipoOrario()
        medicinaleWithTimeCore.raccomandazioni = medicineWithTime.getRaccomandazioni()
        medicinaleWithTimeCore.nome = medicineWithTime.getMedicinale().getNome()
        medicinaleWithTimeCore.time = medicineWithTime.getTime()! as NSDate
        medicinaleWithTimeCore.orario = medicineWithTime.getOrarioApprossimato()
        medicinaleWithTimeCore.quando = medicineWithTime.getQuandoApprossimato()
        medicinaleWithTimeCore.ultimaModifica = medicineWithTime.getUltimaModifica() as NSDate
        medicinaleWithTimeCore.dosaggio = medicineWithTime.getDosaggio()!
        medicinaleWithTimeCore.codiceMed = medicineWithTime.getMedicinale().getCodice()
        medicinaleWithTimeCore.codiceTer = medicineWithTime.getCodiceTerapia()
        medicinaleWithTimeCore.ripetizioni = CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni + Int16(addRipetizione)
        
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio MedicinaleWithTimeCore: \(medicinaleWithTimeCore.id!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    
    func aggiungiTerapiaNonFarmacologicaWithTime(terapiaNonFarmacologicaWithTime: TerapiaNonFarmacologicaWithTime){
        let entity = NSEntityDescription.entity(forEntityName: "TerapiaNonFarmacologicaWithTimeCore", in: self.context)
        
        let terapiaNonFarmacologicaWithTimeCore = TerapiaNonFarmacologicaWithTimeCore(entity: entity!, insertInto: context)
        
        terapiaNonFarmacologicaWithTimeCore.id = terapiaNonFarmacologicaWithTime.getId()
        terapiaNonFarmacologicaWithTimeCore.tipoOrario = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario()
        terapiaNonFarmacologicaWithTimeCore.nome = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
        terapiaNonFarmacologicaWithTimeCore.orario = terapiaNonFarmacologicaWithTime.getOrarioApprossimato()
        terapiaNonFarmacologicaWithTimeCore.quando = terapiaNonFarmacologicaWithTime.getQuandoApprossimato()
        terapiaNonFarmacologicaWithTimeCore.raccomandazioni = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getRaccomandazioni()
        terapiaNonFarmacologicaWithTimeCore.value = terapiaNonFarmacologicaWithTime.getValue()!
        terapiaNonFarmacologicaWithTimeCore.time = terapiaNonFarmacologicaWithTime.getTime()! as NSDate
        terapiaNonFarmacologicaWithTimeCore.codiceTer = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getCodice()
//        terapiaNonFarmacologicaWithTimeCore.ripetizioni = Int16(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getOrarioLibero())
        terapiaNonFarmacologicaWithTimeCore.ripetizioni = 1
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio TerapiaNonFarmacologicaWithTIme: \(terapiaNonFarmacologicaWithTimeCore.id!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    func aggiungiTerapiaNonFarmacologicaWithTimeWithAddRipetizione(terapiaNonFarmacologicaWithTime: TerapiaNonFarmacologicaWithTime, addRipetizione: Int){
        let entity = NSEntityDescription.entity(forEntityName: "TerapiaNonFarmacologicaWithTimeCore", in: self.context)
        
        let terapiaNonFarmacologicaWithTimeCore = TerapiaNonFarmacologicaWithTimeCore(entity: entity!, insertInto: context)
        
        terapiaNonFarmacologicaWithTimeCore.id = terapiaNonFarmacologicaWithTime.getId()
        terapiaNonFarmacologicaWithTimeCore.nome = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
        terapiaNonFarmacologicaWithTimeCore.orario = terapiaNonFarmacologicaWithTime.getOrarioApprossimato()
        terapiaNonFarmacologicaWithTimeCore.quando = terapiaNonFarmacologicaWithTime.getQuandoApprossimato()
        terapiaNonFarmacologicaWithTimeCore.raccomandazioni = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getRaccomandazioni()
        terapiaNonFarmacologicaWithTimeCore.value = terapiaNonFarmacologicaWithTime.getValue()!
        terapiaNonFarmacologicaWithTimeCore.time = terapiaNonFarmacologicaWithTime.getTime()! as NSDate
        terapiaNonFarmacologicaWithTimeCore.codiceTer = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getCodice()
        terapiaNonFarmacologicaWithTimeCore.ripetizioni = CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni + Int16(addRipetizione)
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio TerapiaNonFarmacologicaWithTIme: \(terapiaNonFarmacologicaWithTimeCore.id!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    func existsTerapiaNonFarmacologicaWithTimeFromId(id: String) -> Bool {
        
        let request: NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore> = NSFetchRequest(entityName: "TerapiaNonFarmacologicaWithTimeCore")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        
        var terapieNonFarmacologicheWithTimeCore = [TerapiaNonFarmacologicaWithTimeCore]()
        do {
            terapieNonFarmacologicheWithTimeCore = try self.context.fetch(request)
            
            guard  terapieNonFarmacologicheWithTimeCore.count > 0 else {
                
                return false
                
            }
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return true
        
    }
    
    
    func existsMedicinaleWithTimeFromId(id: String) -> Bool {
        
        let request: NSFetchRequest<MedicinaleWithTimeCore> = NSFetchRequest(entityName: "MedicinaleWithTimeCore")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        
        var medicinaliWithTimeCore = [MedicinaleWithTimeCore]()
        do {
            medicinaliWithTimeCore = try self.context.fetch(request)
            
            guard medicinaliWithTimeCore.count > 0 else {
                
                return false
                
            }
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return true
        
    }
    
    func loadAllMedicinaliWithTimeCore() -> [MedicinaleWithTimeCore] {
        
        var medicinaliWithTimeCore: [MedicinaleWithTimeCore] = []
        
        let fetchRequest: NSFetchRequest<MedicinaleWithTimeCore> = MedicinaleWithTimeCore.fetchRequest()
        
        do {
            
            medicinaliWithTimeCore = try self.context.fetch(fetchRequest)
            
        } catch let errore {
            print("[CDC] Problema esecuzione Medici")
            print("  Stampo l'errore: \n \(errore) \n")
            
        }
        
        return medicinaliWithTimeCore
    }
    
    func loadAllTerapieNonFarmacologicheWithTimeCore() -> [TerapiaNonFarmacologicaWithTimeCore] {
        
        var terapieNonFarmacologicheWithTimeCore: [TerapiaNonFarmacologicaWithTimeCore] = []
        
        let fetchRequest: NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore> = TerapiaNonFarmacologicaWithTimeCore.fetchRequest()
        
        do {
            
            terapieNonFarmacologicheWithTimeCore = try self.context.fetch(fetchRequest)
        
            
        } catch let errore {
            print("[CDC] Problema esecuzione Medici")
            print("  Stampo l'errore: \n \(errore) \n")
            
        }
        
        return terapieNonFarmacologicheWithTimeCore
    }
    
    func aggiungiOrarioEsatto(oEsatto: String){
        let entity = NSEntityDescription.entity(forEntityName: "OrarioEsatto", in: self.context)
        
        let orarioEsatto = OrarioEsatto(entity: entity!, insertInto: context)
        orarioEsatto.orario = oEsatto
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio Orario Esatto: \(orarioEsatto.orario!) in memoria")
            print(" Stampo l'errore: \n \(errore) \n")
        }
    }
    
    func aggiungiImage(image: NSData, name: String){
        let entity = NSEntityDescription.entity(forEntityName: "Images", in: self.context)
        
        let images = Images(entity: entity!, insertInto: context)
        images.name = name
        images.image = image
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio Immagine: \(images.name!) in memoria")
            print(" Stampo l'errore: \n \(errore) \n")
        }
    }
    
    private func loadImagesFromFetchRequest(request: NSFetchRequest<Images>) -> [Images]{
        var dataImages = [Images]()
        do {
            dataImages = try self.context.fetch(request)
            
            guard dataImages.count > 0 else {
                print("[CDC] Non ci sono immagini Core da leggere ")
                return []
                
            }
            
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return dataImages
    }
    
    private func loadMedicinaliWithTimeCoreFromFetchRequest(request: NSFetchRequest<MedicinaleWithTimeCore>) -> [MedicinaleWithTimeCore]{
        var meds = [MedicinaleWithTimeCore]()
        do {
            meds = try self.context.fetch(request)
            
            guard meds.count > 0 else {
                print("[CDC] Non ci sono medicinali with time Core da leggere ")
                return []
                
            }
            
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return meds
    }
    
    private func loadTerNonFarmWithTimeCoreFromFetchRequest(request: NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore>) -> [TerapiaNonFarmacologicaWithTimeCore]{
        var terapie = [TerapiaNonFarmacologicaWithTimeCore]()
        do {
            terapie = try self.context.fetch(request)
            
            guard terapie.count > 0 else {
                print("[CDC] Non ci sono terapie non farmacologiche with time Core da leggere ")
                return []
                
            }
            
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return terapie
    }
    
    func loadImageFromName(nameImage: String) -> Data {
        
        let request: NSFetchRequest<Images> = NSFetchRequest(entityName: "Images")
        request.returnsObjectsAsFaults = false
       
        let predicate = NSPredicate(format: "name = %@", nameImage)
        request.predicate = predicate
      
        let dataImages = self.loadImagesFromFetchRequest(request: request)
        if dataImages.count != 0{
            return dataImages[0].image! as Data
        }
        else{
            return (UIImagePNGRepresentation(UIImage(named: "genericDrug")!) as Data?)!
        }
    }
    
    func loadMedicinaleWithOrarioLiberoFromId(id: String) -> MedicinaleWithTimeCore {
        
        let request: NSFetchRequest<MedicinaleWithTimeCore> = NSFetchRequest(entityName: "MedicinaleWithTimeCore")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        
        let meds = self.loadMedicinaliWithTimeCoreFromFetchRequest(request: request)
        
        return meds[0]
    }
    
    func loadTerNonFarmWithOrarioLiberoFromId(id: String) -> TerapiaNonFarmacologicaWithTimeCore {
        
        let request: NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore> = NSFetchRequest(entityName: "TerapiaNonFarmacologicaWithTimeCore")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        
        let terapie = self.loadTerNonFarmWithTimeCoreFromFetchRequest(request: request)
        
        return terapie[0]
    }
    
    func aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: MedicinaleWithTime){
        
        let med = self.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!)
        
        med.ripetizioni += 1
        
        do {
            try self.context.save()

        } catch let errore {
           
            print(" Stampo l'errore: \n \(errore) \n")
        }
//        self.context.delete(med)
//
//        self.aggiungiMedicinaleWithTimeWithAddRipetizione(medicineWithTime: medicineWithTime, addRipetizione: 1)

//        self.delegate?.onSuccessCore()
        
    }
    
    func aggiungiRipetizioneTerapiaNonFarmacologicaWithTimeWithOrarioLibero(terapiaNonFarmacologicaWithTime: TerapiaNonFarmacologicaWithTime){
        
        let ter = loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!)
        
        ter.ripetizioni += 1
        
        do {
            try self.context.save()
            
        } catch let errore {
            
            print(" Stampo l'errore: \n \(errore) \n")
        }
        
//        self.context.delete(ter)
        
//        self.aggiungiTerapiaNonFarmacologicaWithTimeWithAddRipetizione(terapiaNonFarmacologicaWithTime: terapiaNonFarmacologicaWithTime, addRipetizione: 1)

//        self.delegate?.onSuccessCore()
    
    }
    
    func existsImageFromName(nameImage: String) -> Bool {
        
        let request: NSFetchRequest<Images> = NSFetchRequest(entityName: "Images")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "name = %@", nameImage)
        request.predicate = predicate
        
        var images = [Images]()
        do {
            images = try self.context.fetch(request)
            
            guard images.count > 0 else {
                
                return false
                
            }
            
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        return true
      
    }
        

    func aggiungiMedico(medico: Medico){
            let entity = NSEntityDescription.entity(forEntityName: "MedicoCore", in: self.context)
            
            let newMedico = MedicoCore(entity: entity!, insertInto: context)
            newMedico.codice = medico.getCodice()
            newMedico.nome = medico.getNome()
            newMedico.cognome = medico.getCognome()
            newMedico.recapitoTelefonico = medico.getRecapitoTelefonico()
            
            do {
                try self.context.save()
            } catch let errore {
                print("[CDC] Problema salvataggio Medico: \(newMedico.codice!) in memoria")
                print(" Stampo l'errore: \n \(errore) \n")
            }
        }
    
    
    func aggiungiMedicinale(medicinale: Medicinale){
        let entity = NSEntityDescription.entity(forEntityName: "MedicinaleCore", in: self.context)
//        let entity2 = NSEntityDescription.entity(forEntityName: "Dosaggio", in: self.context)
        let newMedicinale = MedicinaleCore(entity: entity!, insertInto: context)
//        let dosaggio = Dosaggio(entity: entity2!, insertInto: context)
       
        newMedicinale.cod = medicinale.getCodice()
        newMedicinale.nome = medicinale.getNome()
        newMedicinale.misuraDosaggio = medicinale.getMisuraDosaggio()
        newMedicinale.imageUrl = medicinale.getImageUrl()
        newMedicinale.dosaggioFisso = medicinale.getDosaggioFisso()
        newMedicinale.dosaggioVaria = Dosaggio.convert(dictionary: medicinale.getDosaggioVariabile())
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio Medicinale: \(newMedicinale.cod!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    func aggiungiTerapiaFarmacologica(terapiaFarmacologica: TerapiaFarmacologica, medicinali : [Medicinale]){
        let entity = NSEntityDescription.entity(forEntityName: "TerapiaFarmacologicaCore", in: self.context)

        let newTerapiaFarmacologica = TerapiaFarmacologicaCore(entity: entity!, insertInto: context)
        newTerapiaFarmacologica.codice = terapiaFarmacologica.getCodice()
        newTerapiaFarmacologica.cadenza = terapiaFarmacologica.getCadenza()
        newTerapiaFarmacologica.raccomandazioni = terapiaFarmacologica.getRaccomandazioni()
        newTerapiaFarmacologica.tipoOrario = terapiaFarmacologica.getTipoOrario()
        newTerapiaFarmacologica.addToMedicinali(MedicinaleCore.convert(array: medicinali))
        
        newTerapiaFarmacologica.addToOrariEsatti(OrarioEsatto.convert(array: terapiaFarmacologica.getOrarioEsatto()))
        newTerapiaFarmacologica.orariApprossimati = OrarioApprossimato.convert(dictionary: terapiaFarmacologica.getOrarioApprossimato())
        newTerapiaFarmacologica.orarioLibero = Int16(terapiaFarmacologica.getOrarioLibero())
         
//        let setMedicine = NSSet()
//        
//        for medicina in terapiaFarmacologica.getMedicinali() {
//            
//            setMedicine.adding(medicina)
//        }
//        
//        newTerapiaFarmacologica.medicinali = setMedicine
//        print("guarda svelto Ter Farm COREDATA: \(newTerapiaFarmacologica.medicinali!)")

        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio TerFarm: \(newTerapiaFarmacologica.codice!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }

    func aggiungiTerapiaNonFarmacologica(terapiaNonFarmacologica: TerapiaNonFarmacologica){
        let entity = NSEntityDescription.entity(forEntityName: "TerapiaNonFarmacologicaCore", in: self.context)
//        let entity2 = NSEntityDescription.entity(forEntityName: "OrarioEsatto", in: self.context)
     
//        let orarioEsatto = OrarioEsatto(entity: entity2!, insertInto: context)

        let newTerapiaNonFarmacologica = TerapiaNonFarmacologicaCore(entity: entity!, insertInto: context)
        newTerapiaNonFarmacologica.codice = terapiaNonFarmacologica.getCodice()
        newTerapiaNonFarmacologica.cadenza = terapiaNonFarmacologica.getCadenza()
        newTerapiaNonFarmacologica.raccomandazioni = terapiaNonFarmacologica.getRaccomandazioni()
        newTerapiaNonFarmacologica.tipoOrario = terapiaNonFarmacologica.getTipoOrario()
    
        //QUI CONTINUA LA PARTE BUONA
        newTerapiaNonFarmacologica.addToOrariEsatti(OrarioEsatto.convert(array: terapiaNonFarmacologica.getOrarioEsatto()))
        newTerapiaNonFarmacologica.orariApprossimati = OrarioApprossimato.convert(dictionary: terapiaNonFarmacologica.getOrarioApprossimato())
        newTerapiaNonFarmacologica.orarioLibero = Int16(terapiaNonFarmacologica.getOrarioLibero())
        newTerapiaNonFarmacologica.nome = terapiaNonFarmacologica.getNome()

        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio TerNonFarm: \(newTerapiaNonFarmacologica.codice!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }

    func aggiungiPaziente(paziente: Paziente, terapieFarmacologiche: [TerapiaFarmacologica], terapieNonFarmacologiche: [TerapiaNonFarmacologica], medicoControllo: Medico){
        let entity = NSEntityDescription.entity(forEntityName: "PazienteCore", in: self.context)

        let newPaziente = PazienteCore(entity: entity!, insertInto: context)

        newPaziente.codiceFiscale = paziente.getCodiceFiscale()
        newPaziente.nome = paziente.getNome()
        newPaziente.prossimoControllo = paziente.getProssimoControllo() as NSDate
        newPaziente.cognome = paziente.getCognome()
        newPaziente.ultimaModifica = paziente.getUltimaModifica() as NSDate
        
        newPaziente.terapieFarmacologiche = TerapiaFarmacologicaCore.convert(array: terapieFarmacologiche)
        newPaziente.medicoControllo = MedicoCore.convert(medico: medicoControllo)
        newPaziente.terapieNonFarmacologiche = TerapiaNonFarmacologicaCore.convert(array: terapieNonFarmacologiche)

        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio Paziente: \(newPaziente.codiceFiscale!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }


    func loadAllTerapieFarmacologiche() -> [TerapiaFarmacologica]  {

        var terapieFarm = [TerapiaFarmacologica]()

        let fetchRequest: NSFetchRequest< TerapiaFarmacologicaCore> = TerapiaFarmacologicaCore.fetchRequest()

        do {

            let terapieFarmCore = try self.context.fetch(fetchRequest)

            for terapiaFarmCore in terapieFarmCore {
                let terapiaFarm = TerapiaFarmacologica(codice: terapiaFarmCore.codice!, cadenza: terapiaFarmCore.cadenza!, raccomandazioni: terapiaFarmCore.raccomandazioni!, tipoOrario: terapiaFarmCore.tipoOrario!)
                for med in terapiaFarmCore.medicinali! as! Set<MedicinaleCore>{
                    terapiaFarm.aggiungiMedicinale(medicinale: MedicinaleCore.invert(medicinaleCore: med))
                }

                terapiaFarm.aggiungiOrarioLibero(ripetizione: Int(terapiaFarmCore.orarioLibero))

                var times = String()
                var i = 0
                
                for time in terapiaFarmCore.orariEsatti! as! Set<OrarioEsatto>{
                    times.append(time.orario!)
                    if i < terapiaFarmCore.orariEsatti!.count - 1{
                        times.append(";")
                    }
                    i = i + 1
                }

                terapiaFarm.aggiungiOrarioEsatto(orario: times)

                for row in terapiaFarmCore.orariApprossimati! as! Set<OrarioApprossimato>{

                    terapiaFarm.aggiungiOrarioApprossimato(tipoOrario: row.pranzo!, quando: row.quando!)
                }

                terapieFarm.append(terapiaFarm)

                print("[CDC] Terapia Farmacologica \(terapiaFarmCore.codice!)")
           }

            print("--------END--------------")

        } catch let errore {
            print("[CDC] Problema esecuzione Terapie Farmacologiche")
            print("  Stampo l'errore: \n \(errore) \n")

        }

        return terapieFarm
    }

    func loadAllTerapieNonFarmacologiche() -> [TerapiaNonFarmacologica] {

        var terapieNonFarm = [TerapiaNonFarmacologica]()
        
        let fetchRequest: NSFetchRequest< TerapiaNonFarmacologicaCore> = TerapiaNonFarmacologicaCore.fetchRequest()
        
        do {
            
            let terapieNonFarmCore = try self.context.fetch(fetchRequest)
            
            for terapiaNonFarmCore in terapieNonFarmCore {
                let terapiaNonFarm = TerapiaNonFarmacologica(codice: terapiaNonFarmCore.codice!, nome: terapiaNonFarmCore.nome!, cadenza: terapiaNonFarmCore.cadenza!, raccomandazioni: terapiaNonFarmCore.raccomandazioni!, tipoOrario: terapiaNonFarmCore.tipoOrario!)
                
                terapiaNonFarm.aggiungiOrarioLibero(ripetizione: Int(terapiaNonFarmCore.orarioLibero))
                
                var times = String()
                var i = 0
                // attento vedi bene
//                print(terapiaNonFarmCore.orariEsatti!)
                for time in terapiaNonFarmCore.orariEsatti! as! Set<OrarioEsatto>{
//                    times.append(time as! String)
                    times.append(time.orario!)
                    if i < terapiaNonFarmCore.orariEsatti!.count - 1{
                        times.append(";")
                    }
                    i = i + 1
                }

                terapiaNonFarm.aggiungiOrarioEsatto(orario: times)
                
                for row in terapiaNonFarmCore.orariApprossimati! as! Set<OrarioApprossimato>{
                    
                    terapiaNonFarm.aggiungiOrarioApprossimato(tipoOrario: row.pranzo!, quando: row.quando!)
                }
                terapieNonFarm.append(terapiaNonFarm)
                
                print("[CDC] Terapia NON Farmacologica: \(terapiaNonFarmCore.codice!)")
            }
            
            print("--------END--------------")
            
        } catch let errore {
            print("[CDC] Problema esecuzione Terapie Farmacologiche")
            print("  Stampo l'errore: \n \(errore) \n")
            
        }

        return terapieNonFarm
        
    }


    func loadAllMedici() -> [Medico] {

        var medici : [Medico] = []

        let fetchRequest: NSFetchRequest<MedicoCore> = MedicoCore.fetchRequest()

        do {
            
            let mediciCore = try self.context.fetch(fetchRequest)

            for medicoCore in mediciCore {
                let medico = Medico(codice: medicoCore.codice!, nome: medicoCore.nome!, cognome: medicoCore.cognome!, recapitoTelefonico: medicoCore.recapitoTelefonico!)
                print("[CDC] Medico Caricato: \(medico.getNome()) - \(medico.getCognome())")

                medici.append(medico)
            }

            print("--------END--------------")

        } catch let errore {
            print("[CDC] Problema esecuzione Medici")
            print("  Stampo l'errore: \n \(errore) \n")

        }

        return medici
    }


    func loadAllPazienti() -> [Paziente] {

        var pazienti : [Paziente] = []

        let fetchRequest: NSFetchRequest<PazienteCore> = PazienteCore.fetchRequest()

        do {
            let pazientiCore = try self.context.fetch(fetchRequest)

            for pazienteCore in pazientiCore {
                
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let paziente = Paziente(codiceFiscale: pazienteCore.codiceFiscale!, nome: pazienteCore.nome!, cognome: pazienteCore.cognome!, prossimoControllo: dateFormatter.string(from: pazienteCore.prossimoControllo! as Date), ultimaModifica: Int((pazienteCore.ultimaModifica?.timeIntervalSince1970)!))
                paziente.aggiungiMedicoControllo(medicoC: CoreDataController.shared.loadAllMedici()[0])
                paziente.aggiungiTerapieFarmacologiche(terapie: CoreDataController.shared.loadAllTerapieFarmacologiche())
                paziente.aggiungiTerapieNonFarmacologiche(terapie: CoreDataController.shared.loadAllTerapieNonFarmacologiche())
                
                pazienti.append(paziente)

            }


        } catch let errore {
            print("[CDC] Problema esecuzione Pazienti")
            print("  Stampo l'errore: \n \(errore) \n")

        }

        return pazienti
    }
    
    
    
//  ALL DELETE
    func deleteAllMedicine(){

        let fetchRequest: NSFetchRequest<MedicinaleCore> = MedicinaleCore.fetchRequest()

        do {
        let array = try self.context.fetch(fetchRequest)

        guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da medicine"); return}

        for x in array {
            let medicina = x
            self.context.delete(medicina)

        }

        } catch let errore {
        print("[CDC] Problema cancellazione oggetti Medicina")
        print("  Stampo l'errore: \n \(errore) \n")
        }

    }


    func deleteAllTerapieFarmacologiche(){

        let fetchRequest: NSFetchRequest<TerapiaFarmacologicaCore> = TerapiaFarmacologicaCore.fetchRequest()

        do {
            let array = try self.context.fetch(fetchRequest)

            guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da terapieFarmacologiche"); return}

            for x in array {
                let terFarm = x
                self.context.delete(terFarm)

            }

        } catch let errore {
            print("[CDC] Problema cancellazione oggetti Terapie Farmacologiche")
            print("  Stampo l'errore: \n \(errore) \n")
        }

    }

    func deleteAllTerapieNonFarmacologiche(){

        let fetchRequest: NSFetchRequest<TerapiaNonFarmacologicaCore> = TerapiaNonFarmacologicaCore.fetchRequest()

        do {
            let array = try self.context.fetch(fetchRequest)

            guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da terapieNONFarmacologiche"); return}

            for x in array {
                let terNonFarm = x
                self.context.delete(terNonFarm)

            }

        } catch let errore {
            print("[CDC] Problema cancellazione oggetti Terapie NON Farmacologiche")
            print("  Stampo l'errore: \n \(errore) \n")
        }

    }

    func deleteAllMedici(){

        let fetchRequest: NSFetchRequest<MedicoCore> = MedicoCore.fetchRequest()

        do {
            let array = try self.context.fetch(fetchRequest)

            guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da Medici"); return}

            for x in array {
                let medico = x
                self.context.delete(medico)

            }

        } catch let errore {
            print("[CDC] Problema cancellazione oggetti Medici")
            print("  Stampo l'errore: \n \(errore) \n")
        }

    }

    func deleteAllPazienti(){

        let fetchRequest: NSFetchRequest<PazienteCore> = PazienteCore.fetchRequest()

        do {
            let array = try self.context.fetch(fetchRequest)

            guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da Pazienti"); return}

            for x in array {
                let paziente = x
                self.context.delete(paziente)

            }

        } catch let errore {
            print("[CDC] Problema cancellazione oggetti Pazienti")
            print("  Stampo l'errore: \n \(errore) \n")
        }

    }
    
    func deleteAllImages(){
        
        let fetchRequest: NSFetchRequest<Images> = Images.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[CDC] Non ci sono elementi da cancellare da Images"); return}
            
            for x in array {
                let paziente = x
                self.context.delete(paziente)
                
            }
            
        } catch let errore {
            print("[CDC] Problema cancellazione oggetti Pazienti")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
    }
    
    func deleteAll(){
        self.deleteAllPazienti()
        self.deleteAllMedici()
        self.deleteAllTerapieNonFarmacologiche()
        self.deleteAllTerapieFarmacologiche()
        self.deleteAllMedicine()
        self.deleteAllImages()
    }

}

protocol CoreDataControllerDelegate{
    func onSuccessCore()
}

