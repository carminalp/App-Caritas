//
//  voluntariosManager.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 14/10/22.
//

import UIKit

/*
 Autora: GERALDINE TORRES
 
 Se crea un arreglo de la clase horasValidadasVoluntario llamado listVoluntarios para guardar todos los voluntarios que s eobtengan por medio de la API.
 
 Al momento de hacer la llamada a la API, si no hay información o si hay algún error, se imprime el mensaje de "error" en la terminal.
 
 En caso de sí haber información, se agregan al arreglo los datos extraidos del voluntario.
 
 */

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
