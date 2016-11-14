//
//  RegisterViewController.swift
//  Subclassing
//
//  Created by Dinesh Reddy.C on 11/11/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

import UIKit
import CoreData
class RegisterViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchResultsUpdating
{

    @IBOutlet weak var tblView: UITableView!
    
    var tabledata = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            self.tblView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    override func viewWillAppear(_ animated: Bool) {
        self .getDataFromServer()
    }
    //MARK: UITABLEVIEW DATASOURCE AND DELEGATE
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return self.filteredTableData.count
        }else{
            return self.tabledata.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"addCategoryCell")
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        if self.resultSearchController.isActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
        } else {
            cell.textLabel?.text = tabledata[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.resultSearchController.isActive {
            print()
           // self.showAlert(title: "SubClassing", message: filteredTableData[indexPath.row])
        } else {
            //self.showAlert(title: "SubClassing", message: tabledata[indexPath.row])
        }
        let obj = self.storyboard? .instantiateViewController(withIdentifier: "CustomCollectionViewController")
        self.navigationController? .pushViewController(obj!, animated: true)

    }
    //MARK: UISEARCHBARCONTROLLER DELEGATE
    func updateSearchResults(for searchController: UISearchController) {
        
        // code here
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF contains[c] %@", searchController.searchBar.text!)
        let array = (tabledata as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.tblView.reloadData()
        
    }

    
    // MARK: - Network Call
    
    //array and key
    
    func getDataFromServer() {
    
            let context = (UIApplication .shared .delegate as! AppDelegate).persistentContainer.viewContext
            do{
                //getting all datas from entity
                let request = self .setFetchReques(entityName: "Listing")   
                request.predicate = self .setPredicate(keyName: "table", entityName: "Listing")
                let temp = try  context.fetch(request)
                if temp .count > 0 {
                    
                    tabledata .removeAll()
                      let objList = temp[0] as! Listing
                    self.tabledata = NSKeyedUnarchiver.unarchiveObject(with:objList.headLine as! Data) as! [String]
                    print(temp)
                    //print(tabledata .count)
                }else{
                    self .getMethodUrl(urlMethod: Contants.CountryList,loadingRequired:true) { (result) in
                        print(result)
                        if let errorArray = result["jobIndustryTypes"].array{
                            self.tabledata .removeAll()
                            //storing every dictionary in core data
                            for item in errorArray {
                                print(item)
                                let values = String(describing: item["value"])
                                self.tabledata.append(values)
                            }
                            
                            let listCore = Listing(context: context)
                            listCore.headLine = NSKeyedArchiver.archivedData(withRootObject: self.tabledata) as NSObject?
                            listCore.key  = "table"
                            (UIApplication .shared .delegate as! AppDelegate).saveContext()
                        }
                        self.tblView.reloadData()
                        
                    }

                }
               
            }catch{
                print("problem with fetching core data")
            }
        
    }
    
    
    
    //stirng and key in core data
//    func getDataFromServer(){
//        let context = (UIApplication .shared .delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            //getting all datas from entity
//            let temp = try  context.fetch(Listing.fetchRequest())
//            tabledata .removeAll()
//            for obj in temp{
//                let objList = obj as! Listing
//                tabledata.append(objList.headLine!)
//            }
//            print(tabledata .count)
//            self.tblView.reloadData()
//        }catch{
//            print("problem with fetching core data")
//        }
//        if tabledata.count > 0 {
//            self.tblView.reloadData()
//        }else{
//        
//        self .getMethodUrl(urlMethod: Contants.CountryList,loadingRequired:true) { (result) in
//            print(result)
//            if let errorArray = result["jobIndustryTypes"].array{
//                var index = 0
//                
//                //storing every dictionary in core data
//                for item in errorArray {
//                    print(item)
//                    let values = String(describing: item["value"])
//                    let listCore = Listing(context: context)
//                    listCore.headLine = values
//                    listCore.key  = String(index)
//                    index = index + 1
//                    (UIApplication .shared .delegate as! AppDelegate).saveContext()
//                    self.tabledata.append(values)
//                }
//            }
//            self.tblView.reloadData()
//
//        }
//      }
//    }

 
}
