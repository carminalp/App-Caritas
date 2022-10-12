//
//  ProyectosViewController.swift
//  appCaritasMty
//
//  Created by Alumno on 01/10/22.
//

import UIKit


class ProyectosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var projectCollectionView: UICollectionView!
    
    var itemList = [projectList]()
    
    var backButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.title = ""
        self.backButton.isEnabled = false
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // aqui van los projects
        itemList.append(projectList(projectName: "Banco de Alimentos", projectDesc: "Maneja alimentos a gran escala para hacerlos llegar a comunidades de extrema pobreza con problemas de desnutrición.",projectActivities: "• Apoyar en la selección, peso y clasificación de alimentos\n• Lavar tarimas y cajas plásticas con pistola y cepillos en exterior del almacén\n• Apoyar en el registro y captura de vales de las instituciones beneficiadas con algún programa", projectImage: UIImage(named: "bancosalimentos")!))
        itemList.append(projectList(projectName: "Banco de Ropa y Artículos Varios", projectDesc: "Da entrada y salida a donativos de ropa, calzado y artículos varios que sean de utilidad a instituciones o a personas de escasos recursos.",projectActivities: "• Apoyar en la selección y clasificación de ropa, calzado y artículos varios, así como en la limpieza de bodegas\n• Apilar cajas con artículos de acuerdo a su contenido antes clasificado\n• Capturar, etiquetar, limpiar y revisar productos para entregarlos en condiciones dignas a quien lo necesita", projectImage: UIImage(named: "bancoropa")!))
        itemList.append(projectList(projectName: "Banco de Medicamentos", projectDesc: "Maneja medicamentos para ser otorgados a gente de escasos recursos que no tiene la posibilidad de adquirirlos.",projectActivities: "• Apoyar en la selección, clasificación y revisión de la caducidad de los medicamentos", projectImage: UIImage(named: "bancomedicamentos")!))
        itemList.append(projectList(projectName: "Posada del Peregrino", projectDesc: "Es un albergue que proporciona servicio asistencial dando alojamiento, alimentación, transportación, asistencia médica y psicológica en forma temporal, a pacientes foráneos de escasos recursos y a sus familiares que acuden a nuestra ciudad en busca de atención médica.",projectActivities: "• Ejercicios de esparcimiento, manualidades, exposición de temas, entre otras actividades con los peregrinos alojados en el albergue\n• Depurar y clasificar los medicamentos\n• Apoyar en la limpieza de bodegas e instalaciones principales del albergue", projectImage: UIImage(named: "posadadelperegrino")!))
        itemList.append(projectList(projectName: "Dignamente Vestido", projectDesc: "Programa que se implementó pensando principalmente en nuestros hermanos migrantes que no cuentan con vestido y calzado en condiciones dignas.",projectActivities: "• Brindar apoyo en la entrega de ropa y calzado a personas migrantes o personas de escasos recursos que lo necesiten\n• Acomodar prendas de acuerdo al género (dama, caballero, niña, niño), talla y temporada", projectImage: UIImage(named: "dignamente-vestido")!))
        itemList.append(projectList(projectName: "Ducha-T", projectDesc: "Programa que va dirigido a personas en situación de calle y migrantes. Consiste en brindar un espacio digno adecuado con regaderas, baños y vestidores, en donde se les proporciona ropa y zapatos en buen estado.",projectActivities: "• Brindar apoyo en la entrega de ropa y calzado a personas de la calle y a migrantes\n• Revisar y limpiar las regaderas, baños y vestidores\n• Brindar atención a personas que solicitan el apoyo, proporcionándoles lo necesario para recibir los servicios antes mencionados\n• Acomodar prendas de acuerdo al género (dama, caballero, niña, niño), talla y temporada", projectImage: UIImage(named: "ducha-t")!))
        itemList.append(projectList(projectName: "Reestructuración de Centros", projectDesc: "En Cáritas tenemos más de 200 centros de servicio como: Dispensarios médicos, Comedores, Cáritas Parroquiales, etc.",projectActivities: "• Limpiar y pintar los centros de servicio para mantenerlos en buenas condiciones", projectImage: UIImage(named: "reestructuracion")!))
        itemList.append(projectList(projectName: "Campañas de Emergencia", projectDesc: "Ante situaciones de desastre, Cáritas se solidariza con el hermano que ha sufrido pérdidas materiales y de alimento.",projectActivities: "• Recibir, clasificar y seleccionar alimentos y ropa que son donados por la comunidad", projectImage: UIImage(named: "emergencia")!))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return itemList.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = projectCollectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCollectionViewCell
          let project = itemList[indexPath.row]
          cell.setupCell(name: project.projectName, desc: project.projectDesc, image: project.projectImage)
          return cell
      }
    

      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let selectedData = itemList[indexPath.row]
          performSegue(withIdentifier: "showDetail", sender: selectedData)
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? projectList else{
            return
        }
        if segue.identifier == "showDetail" {
            guard let destinationVC = segue.destination as? DetalleProyectoViewController else{
                return
            }
            destinationVC.projectReceived = selectedItem
        }
    }
}
