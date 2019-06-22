//
//  MoviesInfoViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/20/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MovieInfoViewController: UIViewController, UITextViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var movieCharacters: UITableView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieEpisode: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieCrawl: UITextView!
    
    let crawlCrawlCrawl = CrawlTableViewCell()
    
    
    let movieManager = MovieManager()
    var movie: Results<Movie>?
    var titleFromCell = ""
    var yOffSet = 0
    var timer: Timer?
    var person: Results<Character>?
    
    var charactersInMovie = [String]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieCrawl.delegate = self
        
        self.movieCharacters.delegate = self
        self.movieCharacters.dataSource = self
        self.movieCharacters.register(UITableViewCell.self, forCellReuseIdentifier: "characterCell")
        
        self.setMovieInfo()
    }
    
    //MARK: - Auto Scroll Crawl Settings
    
    @objc func timerAction() {
        yOffSet += 10
        
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.movieCrawl.contentOffset.y = CGFloat(self.yOffSet)
        })
    }
    
    func autoScrollCrawl() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
}

//MARK: - Movie Info Setup

extension MovieInfoViewController {
    
    func setMovieInfo() {
        
        movieManager.setMovieData()
        self.showInfo()
        
    }
    
    func showInfo() {

        let realm = try! Realm()
        self.movie = realm.objects(Movie.self)
        let predicate = NSPredicate(format: "title = %@", "\(titleFromCell)")
        if let film = self.movie?.filter(predicate).first {
            self.configureUI(film: film)
        } else { }
    }

}

//MARK: - Configure

extension MovieInfoViewController {
    
    func configureUI(film: Movie?) {
        
        self.movieTitle.text = film!.title
        self.movieEpisode.text = String(film!.episodeID)
        self.movieDirector.text = film!.director
        self.movieCrawl.text = film!.crawl
        
        self.crawlCrawlCrawl.setInfo(value: film!.crawl)
        
        
        self.formattingReleaseDate(film: film)
        
        self.movieCrawlConfigurations()
        
        let realm = try! Realm()
        self.person = realm.objects(Character.self)
        let charactersList = film!.characters
        
        self.movieCharactersList(charactersList: charactersList)
        
    }
    
    func movieCrawlConfigurations() {
        
        movieCrawl.layer.borderWidth = 0.5
        movieCrawl.layer.borderColor = UIColor.init(red: 255, green: 212, blue: 121, alpha: 0.1).cgColor
        movieCrawl.layer.cornerRadius = 8
        
        self.autoScrollCrawl()
        
    }
    
    func formattingReleaseDate(film: Movie?) {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        let date: Date? = dateFormatterGet.date(from: film!.releaseDate)
        let formattedDate: String? = dateFormatterPrint.string(from: date!)
        
        
        self.movieReleaseDate.text = formattedDate
        
    }
    
    func movieCharactersList(charactersList: List<String>) {
    
        for character in charactersList {
            
            let realm = try! Realm()
            self.person = realm.objects(Character.self)
            let predicate = NSPredicate(format: "url = %@", "\(character)")
            let person = realm.objects(Character.self).filter(predicate).first!
            let name = person.name
            self.charactersInMovie.append(name)
            
        }

    }
    
}

//MARK: - Characters List

extension MovieInfoViewController:  UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.charactersInMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.movieCharacters.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        let character = charactersInMovie[indexPath.row]
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = character
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CharacterInfoViewController") as! CharacterInfoViewController
        vc.characterIndex = indexPath.row
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)!
        
        let celltext = currentCell.textLabel!.text
        print(celltext!)
        
        vc.name = celltext!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
