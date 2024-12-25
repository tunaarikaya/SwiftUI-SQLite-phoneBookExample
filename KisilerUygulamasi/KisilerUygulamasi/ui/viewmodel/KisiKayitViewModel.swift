

import Foundation

class KisiKayitViewModel {
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func kaydet(kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad,kisi_tel])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
