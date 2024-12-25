
import Foundation

class KisiDetayViewModel {
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func guncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ?, kisi_tel = ? WHERE kisi_id = ? ", values: [kisi_ad,kisi_tel,kisi_id])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
