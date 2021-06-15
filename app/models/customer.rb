class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customer, through: :active_relationships, source: :followed
  has_many :follower_customer, through: :passive_relationships, source: :follower
  has_many :customer_rooms
  has_many :chats
  has_many :rooms, through: :customer_rooms
  has_many :community_customers
  has_many :community_posts
  has_many :communities, through: :community_customers
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_one :army_request
  
  scope :valid_men, -> (params) { where(sex: 0, is_valid: true).ransack(params) }
  scope :valid_women, -> (params) { where(sex: 1, is_valid: true).ransack(params) }

  attachment :profile_image
  validates :name, length: { maximum: 20, minimum: 2 }, presence: true
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@\S+\.\S+\z/ }
  validates :sex, presence: true

  enum sex: { man: 0, woman: 1 }
  enum children: { "なし": 0, "あり": 1 }
  enum address: {
    "秘密": 0, "北海道": 1, "青森県": 2, "岩手県": 3, "宮城県": 4, "秋田県": 5, "山形県": 6, "福島県": 7,
    "茨城県": 8, "栃木県": 9, "群馬県": 10, "埼玉県": 11, "千葉県": 12, "東京都": 13, "神奈川県": 14,
    "新潟県": 15, "富山県": 16, "石川県": 17, "福井県": 18, "山梨県": 19, "長野県": 20,
    "岐阜県": 21, "静岡県": 22, "愛知県": 23, "三重県": 24,
    "滋賀県": 25, "京都府": 26, "大阪府": 27, "兵庫県": 28, "奈良県": 29, "和歌山県": 30,
    "鳥取県": 31, "島根県": 32, "岡山県": 33, "広島県": 34, "山口県": 35,
    "徳島県": 36, "香川県": 37, "愛媛県": 38, "高知県": 39,
    "福岡県": 40, "佐賀県": 41, "長崎県": 42, "熊本県": 43, "大分県": 44, "宮崎県": 45, "鹿児島県": 46,
    "沖縄県": 47,
  }, _suffix: true

  enum annual_income: {
    "秘密": 0, "~250": 1, "250~350": 2, "350~450": 3,
    "450~550": 4, "550~650": 5, "650~750": 6, "750~": 7,
  }, _suffix: true

  enum personality: {
    "未設定": 0, "明るい": 1, "おとなしい": 2, "ポジティブ": 3,
    "まじめ": 4, "社交的": 5, "おおらか": 6,
  }, _suffix: true

  # お気に入りする
  def follow(customer_id)
    active_relationships.create(followed_id: customer_id)
  end
  
  # お気に入りから外す
  def unfollow(customer_id)
    active_relationships.find_by(followed_id: customer_id).destroy
  end
  
  # すでにお気に入りしているのか確認
  def following?(customer)
    following_customer.include?(customer)
  end
  
  # 互いにお気に入りしている状態
  def matchers
    Customer.where(id: passive_relationships.select(:follower_id))
     .where(id: active_relationships.select(:followed_id))
  end
  
  # 生年月日から年齢を計算
  def age
    (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
  end
  
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
