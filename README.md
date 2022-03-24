# Social-media-table
- 야곰의 오토레이아웃 정복하기

## 요구 사항 
<img src = "https://user-images.githubusercontent.com/26668309/159870759-1bd46354-3efd-4b5b-9246-89fef98c86d7.png" width = 60%>

<img src = "https://user-images.githubusercontent.com/26668309/159873306-d54b7925-a50b-47b3-aab3-3f89704c955b.gif" width = 30%>



# AutoLayout 

- profileImage, autherLabel, timeLabel 한 스택뷰에 있는 경우에 width이 모호하므로 autherLabel HuggingPriority 최상으로 설정

```Swift 
        profileImageView = UIImageView()
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        
        authorLabel = UILabel()
        authorLabel.adjustsFontForContentSizeCategory = true
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.textColor = .black
        authorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        authorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        authorLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        
        timeLabel = UILabel()
        timeLabel.adjustsFontForContentSizeCategory = true
        timeLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        timeLabel.textColor = .darkGray
        timeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, authorLabel, timeLabel])
        profileStack.axis = .horizontal
        profileStack.spacing = UIStackView.spacingUseSystem

```
