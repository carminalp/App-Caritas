//
//  voluntariosManager.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 14/10/22.
//

import UIKit

struct voluntariosManager{
    
    func fetchVoluntarios(completionHandler:@escaping ([horasValidadasVoluntario]) -> Void){
        
        var listVoluntarios = [horasValidadasVoluntario]()
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasVal") else {return}
        
        let group = DispatchGroup()
        group.enter()
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil || data == nil {
                print("error")
            }
            else{
                if let responseText = String.init(data: data!, encoding: .ascii){
                    let jsonData = responseText.data(using: .utf8)!
                    listVoluntarios = try! JSONDecoder().decode([horasValidadasVoluntario].self, from: jsonData)
                    completionHandler(listVoluntarios)
                }
            }
        })
        
        task.resume()
    }
    
    func getNombresVoluntarios() -> [String] {
        var nombresVoluntarios = [String] ()
        var listVoluntarios = [horasValidadasVoluntario]()

        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasVal") else {
            return []
        }

        let group = DispatchGroup()
        group.enter()

        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil || data == nil {

                print("error")
            }
            else{
                if let responseText = String.init(data: data!, encoding: .ascii){
                    let decoder = JSONDecoder()
                    let jsonData = responseText.data(using: .utf8)!

                    listVoluntarios = try! decoder.decode([horasValidadasVoluntario].self, from: jsonData)

                    if(!listVoluntarios.isEmpty){
                        listVoluntarios.forEach{ i in
                            print("-------- Jaló ---------")
                            nombresVoluntarios.append(i.Nombre)
                            print(i.Nombre)
                        }
                    }
                }
            }
        })

        task.resume()

        return nombresVoluntarios
    }
    
    
//    func getNombresVoluntarios() -> [String] {
//        var nombresVoluntarios = [String] ()
//        var listVoluntarios = [horasValidadasVoluntario]()
//        
//        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasVal") else {
//            return []
//        }
//        
//        let group = DispatchGroup()
//        group.enter()
//        
//        let task = URLSession.shared.dataTask(with: url){
//            data, response, error in
//                    if let data = data{
//                        do{
//                            let decoder = JSONDecoder()
//                            let tasks = try decoder.decode([horasValidadasVoluntario].self, from: data)
//                            if (!tasks.isEmpty){
//                                tasks.forEach{ i in
//                                    print("-------- Jaló ---------")
//                                    nombresVoluntarios.append(i.Nombre)
//                                    
//                                }
//                            }else{
//                                print("----- ERROR -----")
//                            }
//                        }catch{
//                            print(error)
//                            print("----- ERROR2 -----")
//                        }
//                    }
//            group.leave()
//        }
//        
//        task.resume()
//        group.wait()
////        createsPickers()
//        
//        return nombresVoluntarios
//    }


    
}
