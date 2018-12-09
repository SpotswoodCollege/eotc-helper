class ActivitiesController < ApplicationController
  # Official Ministry of Education guidelines from the EOTC Guidelines 2016
  # Source: http://eotc.tki.org.nz/EOTC-home/EOTC-Guidelines
  # Accessed Friday December 7, 2018
  # TODO: Should this be in the model? Or possibly a config file?
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

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(activity_params)

    @activity.creator = current_user.id if user_signed_in?
    @activity.edited_at = @activity.created_at

    if @activity.save
      redirect_to @activity
    else
      render 'new', status: :bad_request
    end
  end

  def update
    @activity = Activity.find(params[:id])
    @activity.edited_at = @activity.updated_at

    if @activity.update(activity_params)
      redirect_to @activity
    else
      render 'edit', status: :bad_request
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :activity_type, :risk)
  end
end
