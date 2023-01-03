import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var shapeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let url: String = "https://developers.themoviedb.org/3/movies/get-movie-images"
    
    func getMovieImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
        
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            
            switch response.statusCode {
            case 200:
                print("성공")
                print(url)
                let movie = try? JSONDecoder().decode(Movie.self, from: data)
                if let movie = movie {
                    if let imageFile = UIImage(contentsOfFile: movie.posters[0].file_path!) {
                        DispatchQueue.main.async {
                            self.movieImage.image = imageFile
                            self.shapeLabel.text = "\(String(movie.posters[0].width!)) / \(String(movie.posters[0].height!))"
                        }
                    }
                }
                
            default:
                print("연결 실패")
            }
        }
        dataTask.resume()
    }
    
    @IBAction func posterGenerateButton(_ sender: UIButton) {
        getMovieImage(url: url)
    }
}

