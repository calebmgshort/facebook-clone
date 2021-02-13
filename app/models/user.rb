class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  def friends
    sql = basic_friends_query + "
    AND
    accepted = true
    "
    ActiveRecord::Base.connection.execute(sql)
  end

  def pending_friend_requests
    sql = "SELECT Friends.email
    FROM Users 
    JOIN User_Friend on (Users.id = requestee_id)
    JOIN Users as Friends on (Friends.id = requester_id)
    WHERE Users.id = #{self.id} and User_Friend.accepted = false
    "
    ActiveRecord::Base.connection.execute(sql)
  end

  def suggested_friends
    # First, get all of the friends
    sql = "SELECT email 
    FROM Users
    WHERE NOT EXISTS (
      SELECT 1 FROM ( " + basic_friends_query + " AND friend_id = Users.id ) as all_friends
    ) AND Users.id != #{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def basic_friends_query
    "SELECT * FROM (
      SELECT users.id as user_id, friends.id as friend_id, friends.email as friend_email, user_friend.accepted
      FROM Users 
      JOIN User_Friend on (Users.id = requester_id)
      JOIN Users as Friends on (Friends.id = requestee_id)
      UNION ALL
      SELECT users.id as user_id, friends.id as friend_id, friends.email as friend_email, user_friend.accepted
      FROM Users 
      JOIN User_Friend on (Users.id = requestee_id)
      JOIN Users as Friends on (Friends.id = requester_id)
      ) as all_friends
      WHERE user_id = #{self.id}
    "
  end

end
