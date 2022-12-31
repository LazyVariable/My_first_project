//
//  CalculatorCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.12.2022.
//

import UIKit

public class InputData{
    var value: String?
}
class CalculatorCell: UITableViewCell {
    static var reuseId = "CalculatorView"
    
    lazy var inputButtonNames = ["1", "2", "3","4", "5", "6","7", "8", "9", ".", "0"] // strelka - ←
    private var model: InputData?

    
    private lazy var displayingData: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let paddingSize = Layout.paddingCount * Layout.padding
        let cellSize = (UIScreen.width - paddingSize) / Layout.itemsCoutn
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = Layout.padding
        layout.minimumInteritemSpacing = Layout.padding
        layout.sectionInset = UIEdgeInsets(top: Layout.padding, left: Layout.padding, bottom: Layout.padding, right: Layout.padding)
        
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalculatorCollectionCell.self, forCellWithReuseIdentifier: CalculatorCollectionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: InputData)
    {
        self.model = model
    }
    // MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(displayingData)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = CustomColors.cyan
    }
    
    private func setupConstraints() {

        
        displayingData.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(displayingData.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
extension CalculatorCell: UICollectionViewDelegate {
  
}
extension CalculatorCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputButtonNames.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculatorCollectionCell.reuseId, for: indexPath) as? CalculatorCollectionCell else { return UICollectionViewCell() }

        var command:ButtonCellCommand
        if indexPath.row < inputButtonNames.count {
            let button = inputButtonNames[indexPath.row]

            if button == "." {
                command = DotCellCommand(label: displayingData, input: model)
            }
            else{
                command = InputCellCommand(text: button, label: displayingData, input:  model)
            }
            command = ValidatorNumbers(command: command, label: displayingData)
        }
        else{
            command = CeCellCommand(label: displayingData, input: model)
        }
        cell.configure(model: command)
        
        return cell
    }
    
    
}


extension CalculatorCell {
    struct Layout {
        static let itemsCoutn: CGFloat = 3
        static let padding: CGFloat = 20
        static let paddingCount: CGFloat = itemsCoutn + 1
    }
}

