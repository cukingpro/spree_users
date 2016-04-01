module Spree
  module Api
    class SurveysController < Spree::Api::BaseController

      def create
        @survey = Survey::Survey.new(survey_params)
        @status = if @survey.save
          [{ "messages" => "Your survey was successfully created" }]
        else
          [{ "messages" => "Your survey was not successfully created" }]
        end
        render "spree/api/logger/log"
      end

      def check
        @status = if Survey::Survey.exists?(user_id: current_user_id)
          [{ "messages" => "true" }] #User survey already exists
        else
          [{ "messages" => "false" }] #User survey available
        end
        render "spree/api/logger/log"
      end

      def user_survey
        @survey = Survey::Survey.find_by(user_id: current_user_id)
        render "spree/api/surveys/show"
      end

      private

      def survey_params
        params.
          require(:survey).
          permit(:family, {:liked_ingredient_ids => []}, {:hated_ingredient_ids => []}, :habit).
          merge(user_id: current_user_id)
      end


    end
  end
end
