# Swift_Practice_Five


#### 添加TabBar，NavigationBar
```
 override func viewDidLoad() {
        super.viewDidLoad()

        let A = self.setChildViewController(vc: SingleViewController.init(), title: "照片", image: "photo_un", selectedImage: "photo")
        let B = self.setChildViewController(vc: GroupViewController.init(), title: "相册", image: "PhotoGroup_un", selectedImage: "PhotoGroup")
        self.viewControllers = [A,B]
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    func setChildViewController(vc: UIViewController, title: NSString,image: NSString,selectedImage: NSString) -> UIViewController{
        let Nav = UINavigationController.init(rootViewController: vc)
//        去除导航栏黑线
        Nav.navigationBar.shadowImage = UIImage.init()
        Nav.navigationBar.backgroundImage(for: UIBarMetrics.default)
        Nav.tabBarItem.title = title as String
        Nav.tabBarItem.image = UIImage.init(named: image as String)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        Nav.tabBarItem.selectedImage = UIImage.init(named: selectedImage as String)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        return Nav
    }
```

#### 数据model对象

```
class BaseModel: NSObject {
    let name: String
    let group: String
    let date: String
    init(name: String, group: String, date: String) {
        self.name = name
        self.group = group
        self.date = date
    }
}

class CurrentModel: NSObject {
    var Array: [BaseModel] = []
    override init() {
        Array = [BaseModel.init(name: "chatroom_cover_page_1", group: "风景", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_2", group: "人物", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_3", group: "美食", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_4", group: "宠物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_5", group: "风景", date: "2019-10-3"),
                 BaseModel.init(name: "chatroom_cover_page_6", group: "风景", date: "2019-10-3"),
                 BaseModel.init(name: "chatroom_cover_page_7", group: "人物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_8", group: "人物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_9", group: "风景", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_10", group: "风景", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_11", group: "美食", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_12", group: "美食", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_13", group: "美食", date: "2019-10-1"),
        ]
    }
}
```

#### 使用CollectionView去展示照片

```
    let identifier: String = "identifier"
    let headIdentifier: String = "headIdentifier"
    var modelArray:[BaseModel] = CurrentModel.init().Array
    var singleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "照片"
        setCurrentSingleCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setUseCurrentModel(array: [BaseModel], section: Int) -> [BaseModel] {
        var currentArray:[BaseModel] = []
        let currentDate: String = self .getCurrentDate(section: section)
        for model:BaseModel in array {
            if model.date == currentDate{
                currentArray.append(model)
            }
        }
        return currentArray
    }
    
    func getCurrentDate(section: Int) -> String {
        var currentDate: String = ""
        if section == 0 {
            currentDate = "2019-10-3"
        }else if section == 1{
            currentDate = "2019-10-2"
        }else if section == 2{
            currentDate = "2019-10-1"
        }
        return currentDate
    }
    
    func setCurrentSingleCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize.init(width: view.frame.width / 4.0 - 1, height: view.frame.width / 4.0 - 1)
        flow.minimumLineSpacing = 5
        flow.minimumInteritemSpacing = 1
        
        singleCollectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flow)
        singleCollectionView.delegate = self
        singleCollectionView.dataSource = self
        singleCollectionView.register(SingleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        singleCollectionView.register(SingleCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headIdentifier)
        singleCollectionView.backgroundColor = UIColor.white
        view.addSubview(singleCollectionView)
    }

  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: self.view.frame.size.width, height: 50)
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if kind == UICollectionView.elementKindSectionHeader{
            let headView: SingleCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headIdentifier, for: indexPath) as! SingleCollectionReusableView
            let nameLabel = UILabel.init(frame: headView.bounds)
            nameLabel.font = UIFont.systemFont(ofSize: 13)
            nameLabel.textColor = UIColor.black
            nameLabel.text = self.getCurrentDate(section: indexPath.section)
            headView.addSubview(nameLabel)
            return headView
        }else{
            return UICollectionReusableView.init()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setUseCurrentModel(array: self.modelArray, section: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SingleCollectionViewCell
        let model: BaseModel = setUseCurrentModel(array: self.modelArray, section: indexPath.section)[indexPath.row]
        cell.setCurrentImageView(imgName: model.name)
        return cell
        
    }
    
    //    字符串 -> 日期
    func stringToDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    //    日期 -> 字符串
    func dateToString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    //    日期比较
    func dateCompare() -> Void {
        let date1 = Date()
        let date2 = Date()
        // date1 < date2 升序排列
        if date1.compare(date2) == .orderedAscending{
            print("<")
        }else if date1.compare(date2) == .orderedDescending{
            print("<")
        }else{
            print(" = ")
        }
    }
```

##### 相片UICollectionViewCell

```
 
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView.init(frame: self.contentView.bounds)
        self.contentView.addSubview(imgView)
    }
    
    func setCurrentImageView(imgName: String) -> Void {
        imgView.image = UIImage.init(named: imgName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

#### 使用UICollectionvView展示相册

```

    let identifier: String = "identifier"
    let headIdentifier: String = "headIdentifier"
    var groupCollectionView: UICollectionView!
    
    var modelArray:[BaseModel] = CurrentModel.init().Array
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "相册"
        setCurrentgroupCollectionView()
        // Do any additional setup after loading the view.
    }
    
//    获取不同的组
    func getGroupFromModel() -> NSArray {
        let dic: NSMutableDictionary = NSMutableDictionary.init()
        let groupArray: NSMutableArray = NSMutableArray.init()
//        获取组名
        for baseModel in modelArray {
            groupArray.add(baseModel.group)
        }
//        去除重复的组名
        for group in groupArray {
            dic.setObject(group, forKey: group as! NSCopying)
        }
        let array:NSMutableArray = NSMutableArray (array: dic.allKeys)
        array.insert("所有照片", at: 0)
        return array
    }
//    根据不同组，获取每个组的总数，每个组的一个图片
    func getImgNameFromGroup(row: Int) -> String {
        let name = getGroupFromModel()[row] as! String
        var group = ""
        self.count = 0
        
        for model in modelArray {
            if name == model.group{
                group = model.name
                self.count += 1
            }
        }
//        特殊处理所有照片：选取第一个为展示图片，数目为 所有
        if name == "所有照片" {
            self.count = modelArray.count
            let model: BaseModel = modelArray[0]
            group = model.name
        }
        return group
    }
    func setCurrentgroupCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize.init(width: (view.frame.width - 20) / 3.0 - 5, height: (view.frame.width - 20) / 3.0 + 40)
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 5
        
        groupCollectionView = UICollectionView.init(frame: CGRect(x: 10, y: 74, width: view.frame.width - 20, height: view.frame.height - 74), collectionViewLayout: flow)
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        groupCollectionView.register(GroupCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
        groupCollectionView.backgroundColor = UIColor.white
        view.addSubview(groupCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getGroupFromModel().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GroupCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GroupCollectionViewCell
        cell.setCurrentUI(imgName: getImgNameFromGroup(row: indexPath.row), name: getGroupFromModel()[indexPath.row] as! String, count: self.count)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.imgName = getGroupFromModel()[indexPath.row] as! String
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
   
```

##### 相册UICollectionViewCell

```
 var imgView = UIImageView()
    var nameLable = UILabel()
    var countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        nameLable = UILabel.init(frame: CGRect(x: 0, y: frame.size.width + 10, width: frame.size.width, height: 20))
        nameLable.font = UIFont.systemFont(ofSize: 18)
        nameLable.textColor = UIColor.black
        countLabel = UILabel.init(frame: CGRect(x: 0, y: frame.size.width + 35, width: frame.size.width, height: 10))
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.textColor = UIColor.black
        contentView.addSubview(imgView)
        
        contentView.addSubview(nameLable)
        contentView.addSubview(countLabel)
    }
    
    func setCurrentUI(imgName: String, name: String, count: Int) -> Void {
        imgView.image = UIImage.init(named: imgName)
        nameLable.text = name
        countLabel.text = "\(count)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
```

#### 选择相册详情

```
 override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        getModel()
        self.setCurrentdetailCollectionView()
        // Do any additional setup after loading the view.
    }
    func getModel() -> Void {
        let currentModelArray: [BaseModel] = CurrentModel.init().Array
        for name in currentModelArray{
            if name.group == imgName {
                modelArray.append(name)
            }
        }
//        特殊处理所有照片
        if imgName == "所有照片" {
            modelArray = currentModelArray
        }
    }
    func setCurrentdetailCollectionView() -> Void {
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize.init(width: view.frame.width / 4.0 - 5, height: view.frame.width / 4.0 - 5)
        flow.minimumLineSpacing = 5
        flow.minimumInteritemSpacing = 5
    
        self.detailCollectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flow)
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.register(DetailCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
       self.detailCollectionView.backgroundColor = UIColor.white
        view.addSubview(self.detailCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DetailCollectionViewCell
        let model: BaseModel = modelArray[indexPath.row]
        cell.setCurrentImageView(imgName: model.name)
        return cell
    }
    
```
##### 相册相片详情

```
var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView.init(frame: self.contentView.bounds)
        self.contentView.addSubview(imgView)
    }
    
    func setCurrentImageView(imgName: String) -> Void {
        imgView.image = UIImage.init(named: imgName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```



# Swift_Animation
