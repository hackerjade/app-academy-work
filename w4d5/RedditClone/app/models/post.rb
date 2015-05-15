class Post < ActiveRecord::Base
  validates :author_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
)

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  has_many(:comments)
end
