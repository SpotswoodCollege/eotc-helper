class Activity < ApplicationRecord
  # Official Ministry of Education guidelines from the EOTC Guidelines 2016
  # Source: http://eotc.tki.org.nz/EOTC-home/EOTC-Guidelines
  # Accessed Friday December 7, 2018
  ACTIVITY_DATA = {
    in_school: {
      low_risk: {
        approval: :none,
        parental_consent: :none,
        risk_management_planning: :usual_lesson_planning
      }, high_risk: {
        approval: :blanket,
        parental_consent: :blanket,
        risk_management_planning: %i[usual_lesson_planning generic]
      }
    },
    community: {
      low_risk: {
        approval: %i[senior_teacher coordinator],
        parental_consent: %i[none blanket],
        risk_management_planning: :generic
      }, high_risk: {
        approval: %i[senior_teacher coordinator],
        parental_consent: %i[blanket separate],
        risk_management_planning: :generic
      }
    },
    day_trip:  {
      low_risk: {
        approval: %i[senior_teacher coordinator],
        parental_consent: %i[none blanket],
        risk_management_planning: :generic
      }, high_risk: {
        approval: %i[principal coordinator],
        parental_consent: :separate_and_risk_disclosure,
        risk_management_planning: :specific
      }
    },
    multi_day: {
      low_risk: {
        approval: %i[principal coordinator],
        parental_consent: :separate,
        risk_management_planning: :specific
      }, high_risk: {
        approval: %i[principal board],
        parental_consent: :separate_and_risk_disclosure,
        risk_management_planning: :specific
      }
    }
  }.freeze

  validates :name, presence:   { message: I18n.t('error.brief.no_blank') },
                   uniqueness: { message: I18n.t('error.brief.unique') }

  validates :creator, presence: { message: I18n.t('error.brief.log_in') }

  has_many :assignments, dependent: :destroy
  has_many :groups, -> { distinct }, through: :assignments

  has_many :users, through: :groups

  belongs_to :creator,
             class_name: 'User',
             foreign_key: :creator_id,
             inverse_of: :created_activities

  def can_be_approved_by?(user)
    approval = Array(approval_needed)
    user.role.to_sym.in?(approval) || user.role?(:administrator)
  end

  def parental_consent
    data = ACTIVITY_DATA[activity_type.to_sym][risk.to_sym]
    data[:parental_consent]
  end

  def planning
    data = ACTIVITY_DATA[activity_type.to_sym][risk.to_sym]
    data[:risk_management_planning]
  end

  def approved?
    return true  if approval_needed == :none
    return false if approved_at.nil?
    approved_at >= (edited_at || created_at)
  end

  private

  def approval_needed
    data = ACTIVITY_DATA[activity_type.to_sym][(risk.to_s + '_risk').to_sym]
    data[:approval]
  end
end
