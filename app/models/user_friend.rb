class UserFriend < ActiveRecord::Base
  self.table_name = 'user_friend'
  validates :requester_id, presence: true
  validates :requestee_id, presence: true
  validate :user_id_exists

  def self.remove_friend(user_id, friend_id)
    sql = "DELETE FROM User_friend WHERE 
    (requester_id=#{user_id} and requestee_id=#{friend_id}) or 
    (requester_id=#{friend_id} and requestee_id=#{user_id})"
    ActiveRecord::Base.connection.execute(sql)
  end

  private
  def user_id_exists
    return false if (User.find_by_id(self.requester_id).nil? or User.find_by_id(self.requestee_id).nil?)
  end

end