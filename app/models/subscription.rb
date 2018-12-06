class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user,  presence: { message:
    I18n.translate('error.brief.belong_to', rel: 'user') }
  validates :group, presence: { message:
    I18n.translate('error.brief.belong_to', rel: 'user') }
end
