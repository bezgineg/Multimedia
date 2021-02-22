
import UIKit
import WebKit

class TableViewCell: UITableViewCell {
    
    let webview = WKWebView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webview.load(request)
    }
    
    private func setupLayout() {
        contentView.addSubview(webview)

        let constraints = [
            webview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            webview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            webview.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            webview.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
