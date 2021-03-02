module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_person, only: [:show]

      # GET /people
      def index
        @people = Person.all
      end

      # GET /people/1
      def show; end

      # POST /people
      def create
        @person = Person.new(person_params)

        if @person.save
          render json: @person, status: :created, location: @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /people/1
      def update
        if @person.update(person_params)
          render json: @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # DELETE /people/1
      def destroy
        @person.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_person
        @person = Person.includes(:species, :transports, :planet).find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def person_params
        params.require(:person).permit(:name, :birthday_year, :height, :mass)
      end
    end
  end
end

