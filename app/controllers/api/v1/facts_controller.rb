class Api::V1::FactsController < ApplicationController
    before_action : find_fact, only: [:show, :update, :destroy]

    def index
        @facts = Fact.all
        render json: @facts
    end

    def show
        render json: @fact
    end

    def create
        @fact = Fact.create(fact_params)
        if @fact.save
            render json: @fact
        else
            render error: {error: 'Unable to create fact.'}, status: 400
        end
    end

    def update
        if @fact
            @fact.update(fact_params)
            render json: {message: 'Fact updated successfully.'}, status:200
        else
            render error: {error: 'Unable to update fact.'}, status: 400
        end
    end

    def destroy
        if @fact
            @fact.destroy
            render json: {message: 'Fact deleted successfully.'},status:200
        else
            render error: {error: 'Unable to destroy fact.'}, status:400
        end
    end

    private

    def fact_params
        params.require(:fact).permit(:user_id, :fact, :likes)
    end

    def find_fact
        @fact = Fact.find(params[:id])
    end
end
