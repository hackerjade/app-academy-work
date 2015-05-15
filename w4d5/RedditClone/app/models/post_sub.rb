class PostSub < ActiveRecord::Base
  validates :post, presence: true
  validates :post_id, uniqueness: {scope: :sub_id}


  belongs_to(:post)
  belongs_to(
    :sub,
    class_name: "User",
    foreign_key: :sub_id,
    primary_key: :id
  )
end
