//
//  ViewController.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit

class HomeSessionViewController: UIViewController {

    @IBOutlet weak var sessionTitleLabel: UILabel!
    @IBOutlet weak var sessionDescriptionLabel: UILabel!
    @IBOutlet weak var sessionTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var sessions = [SessionItem]()
    var endpoint: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSessionDataWithEndpoint(endpoint)
    }

    private func loadSessionDataWithEndpoint(_: URL?)-> Void {
        spinner.startAnimating()
        Loader.shared.session(url: endpoint) { [weak self] session in
            self?.sessionTitleLabel.text = session?.title
            self?.sessionDescriptionLabel.text = session?.descSession
            self?.sessions = session?.sessionItem ?? []
            self?.sessionTableView.reloadData()
            self?.spinner.stopAnimating()
        }
    }
}

extension HomeSessionViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for:indexPath)
        let session = sessions[indexPath.row]
        cell.textLabel?.text = session.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sessionVC = (segue.destination as? HomeSessionViewController) {
            let cell = sender as! UITableViewCell
            if var indexPath = self.sessionTableView.indexPath(for: cell){
                sessionVC.endpoint = sessions[indexPath.row].href
            }
        }
    }
}

