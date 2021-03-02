module Api
  module V1
    class PeopleController < ApplicationController
      include Scoppable
      before_action :set_person, only: [:show, :image]

      # GET /people
      def index

        @people = apply_scope(Person, scope_params.to_h)

        paginate
      end

      # GET /people/1
      def show; end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_person
        @person = Person.includes(:species, :transports, :planet).find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def person_params
        params.require(:person).permit(:name, :birthday_year, :height, :mass)
      end

      def page
        params[:page] || 1
      end

      def scope_params
        params.permit(:by_planet, :by_starship, :by_vehicle)
      end

      # Workaround: only paginate if we do not have filter scopes
      def paginate
        @people = Person.paginate(page: page, per_page: 10) if scope_params.blank?
      end
    end
  end
end

