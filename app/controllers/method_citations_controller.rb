class MethodCitationsController < ApplicationController
  def show
    @method_citation = MethodCitation.find(params[:id])
  end
end
