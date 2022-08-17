import UIKit
import Alamofire

class UserViewController : UIViewController {
    
    let profileView = UIView()
    let nameLabel = UILabel()
    let detailButton = UIButton()
    let tableView = UITableView()
    
    var result: [GetMyList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        view.backgroundColor = .white
        profileSet()
        nameLabelSet()
        configureDetailButton()
        lineView()
        tableviewSize()
        
        tableView.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyToDoList()
    }
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "UserListCell")
        
        tableView.snp.makeConstraints{
            $0.height.equalTo(500)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(320)
            $0.leading.equalTo(0)
            
        }
    }
    
    func getMyToDoList() {
        
        let url = "http://44.209.75.36:8080/todos/list?todoYearMonth=2022-08"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("")
        print("====================================")
        print("-------------------------------")
        print("주 소 :: ", url)
        print("====================================")
        print("")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    
                    if let data = try? JSONDecoder().decode([GetMyList].self, from: response.data!) {
                        DispatchQueue.main.async {
                            print(data)
                            self.result = data
                            self.tableView.reloadData()
                        }
                    } else {
                        print("tlqkf==================================")
                    }
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("====================================")
                    debugPrint(response)
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
    
    func profileSet() {
        
        view.addSubview(profileView)
        profileView.backgroundColor = .black
        profileView.layer.cornerRadius = 50
        
        profileView.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.trailing.equalTo(-300)
            $0.top.equalTo(160)
            $0.leading.equalTo(30)
        }
    }
    
    func lineView() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(10)
            $0.width.equalTo(325)
            $0.trailing.equalTo(0)
            $0.top.equalTo(310)
            $0.leading.equalTo(0)
        }
    }
    
    func nameLabelSet() {
        view.addSubview(nameLabel)
        
        nameLabel.textColor = .black
        nameLabel.text = "박준하"
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        nameLabel.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.trailing.equalTo(-100)
            $0.top.equalTo(185)
            $0.leading.equalTo(160)
        }
    }
    
    func configureDetailButton() {
        detailButton.setTitle("상세보기", for: .normal)
        detailButton.backgroundColor = .black
        
        view.addSubview(detailButton)
        
        detailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        detailButton.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(115)
            $0.trailing.equalTo(-120)
            $0.top.equalTo(225)
            $0.leading.equalTo(160)
        }
        detailButton.addTarget(self, action: #selector(DetailButtonAction), for: .touchUpInside)
    }
    @objc func DetailButtonAction(sender: UIButton!){
        print(" 상세보기 버튼 실행됨")
    }
}

extension UserViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? HomeListCell
        cell?.titleLable.text = "\(result[indexPath.row].title)"
        cell?.contentLable.text = "\(result[indexPath.row].todoData)"
        nameLabel.text = "\(result[indexPath.row].id)"

        return cell!
    }
}


//view미리보기
import SwiftUI

struct UserViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UserViewController {
        return UserViewController()
    }
    
    func updateUIViewController(_ uiViewController: UserViewController, context: Context) { }
    
    
    typealias UIViewControllerType = UserViewController
}

@available(iOS 13.0.0, *)
struct UserViewPreview: PreviewProvider {
    static var previews: some View {
        UserViewControllerRepresentable()
    }
}