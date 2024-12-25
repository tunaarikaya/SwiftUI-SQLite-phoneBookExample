
import SwiftUI

struct Anasayfa: View {
    @State private var aramaKelimesi = ""
    
    @ObservedObject private var viewModel = AnasayfaViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.kisilerListesi){ kisi in
                    NavigationLink(destination: KisiDetaySayfa(kisi: kisi)){
                        KisilerSatir(kisi: kisi)
                    }
                }.onDelete(perform: sil)
            }.navigationTitle("Kişiler")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: KisiKayitSayfa()){
                            Image(systemName: "plus")
                        }
                    }
                }.onAppear{
                    veritabaniKopyala()
                    viewModel.kisileriYukle()
                }
        }.searchable(text: $aramaKelimesi,prompt: "Ara")
            .onChange(of: aramaKelimesi){ _ , s in
                viewModel.ara(aramaKelimesi: s)
            }
    }
    
    func sil(at offsets:IndexSet){
        let kisi = viewModel.kisilerListesi[offsets.first!]
        viewModel.sil(kisi_id: kisi.kisi_id!)
    }
    
    func veritabaniKopyala(){
            let bundle = Bundle.main.path(forResource: "rehber", ofType: ".sqlite")
            
            let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("rehber.sqlite")
            
            let fm = FileManager.default
            
            if fm.fileExists(atPath: hedefYol.path) {
                print("Veritabanı daha önce kopyalanmış.")
            }else{
                do{
                    try fm.copyItem(atPath: bundle!, toPath: hedefYol.path)
                }catch{
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    Anasayfa()
}
