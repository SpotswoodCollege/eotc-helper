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
        approval: %i[senior coordinator],
        parental_consent: %i[none blanket],
        risk_management_planning: :generic
      }, high_risk: {
        approval: %i[senior coordinator],
        parental_consent: %i[blanket separate],
        risk_management_planning: :generic
      }
    },
    day_trip:  {
      low_risk: {
        approval: %i[senior coordinator],
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

  has_many :assignments, dependent: :destroy
  has_many :groups, through: :assignments, uniq: true

  has_many :users, through: :groups

  def can_be_approved_by?(user)
    approval = Array(approval_needed)
    user.role.in? approval
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
    data = ACTIVITY_DATA[activity_type.to_sym][risk.to_sym]
    data[:approval]
  end
end
