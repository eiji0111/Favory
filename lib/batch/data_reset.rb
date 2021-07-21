class Batch::DataReset
  def self.data_reset
    # 30日前の日付を取得する
    days_ago_30 = Time.now - 2592000 # 30日前
    # 自衛官申請をを全て削除
    army_requests = ArmyRequest.all
    army_requests.each do |ar|
      if ar.created_at < days_ago_30
        ar.delete
      end
    end
  end
end