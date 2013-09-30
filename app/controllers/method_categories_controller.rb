class MethodCategoriesController < ApplicationController

  def show
    @method_category = MethodCategory.find(params[:id])
  end

end
