
import UIKit
import AVFoundation

class TableHeaderView: UIView {

    var player = AVAudioPlayer()
    var index = 0
    
    lazy var songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = SongStorage.songs[0]
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(self, action: #selector(pauseMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(stopMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var backwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.addTarget(self, action: #selector(showPreviousSong), for: .touchUpInside)
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.addTarget(self, action: #selector(showNextSong), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        preparePlayer(with: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func preparePlayer(with index: Int) {
        let path = Bundle.main.path(forResource: SongStorage.songs[index], ofType: "mp3")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
            }
            catch {
                print("Error")
            }
        } else {
            return
        }
    }
    
    @objc private func playMusic() {
        player.play()
    }
    
    @objc private func pauseMusic() {
        if player.isPlaying {
            player.pause()
        }
    }
    
    @objc private func stopMusic() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0.0
        }
    }
    
    @objc private func showPreviousSong() {
        index -= 1
        if index < 0 {
            if player.isPlaying {
                index = 4
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
                player.play()
            } else {
                index = 4
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
            }
            
        } else {
            if player.isPlaying {
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
                player.play()
            } else {
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
            }
        }
    }
    
    @objc private func showNextSong() {
        index += 1
        if index == SongStorage.songs.count {
            if player.isPlaying {
                index = 0
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
                player.play()
            } else {
                index = 0
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
            }
        } else {
            if player.isPlaying {
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
                player.play()
            } else {
                preparePlayer(with: index)
                songLabel.text = SongStorage.songs[index]
            }
        }
    }
    
    private func setupLayout() {
        
        addSubview(songLabel)
        addSubview(playButton)
        addSubview(pauseButton)
        addSubview(stopButton)
        addSubview(backwardButton)
        addSubview(forwardButton)
        
        let constraints = [
            
            songLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            songLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            
            pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            pauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            stopButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            stopButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            backwardButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            backwardButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            backwardButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            forwardButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            forwardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            forwardButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
