

import Foundation

class AnasayfaViewModel : ObservableObject{
    @Published var kisilerListesi = [Kisiler]()
    
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func kisileriYukle(){
        db?.open()
        
        var liste = [Kisiler]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while result.next() {
                let kisi_id = Int(result.string(forColumn: "kisi_id"))!
                let kisi_ad = result.string(forColumn: "kisi_ad")!
                let kisi_tel = result.string(forColumn: "kisi_tel")!
                
                let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        kisilerListesi = liste
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        
        var liste = [Kisiler]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like ?", values: ["%\(aramaKelimesi)%"])
            
            while result.next() {
                let kisi_id = Int(result.string(forColumn: "kisi_id"))!
                let kisi_ad = result.string(forColumn: "kisi_ad")!
                let kisi_tel = result.string(forColumn: "kisi_tel")!
                
                let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        kisilerListesi = liste
        
        db?.close()
    }
    
    func sil(kisi_id:Int){
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            kisileriYukle()
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
