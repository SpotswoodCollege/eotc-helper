# Links Users to Groups. Accessed using Subscribe buttons.
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user,  presence: { message:
    I18n.t('error.brief.belong_to', rel: 'user') }
  validates :group, presence: { message:
    I18n.t('error.brief.belong_to', rel: 'user') }

  validates :group_id, uniqueness: { scope: :user_id }
end
