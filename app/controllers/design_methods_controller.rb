class DesignMethodsController < ApplicationController
  # GET /design_methods
  # GET /design_methods.json
  def index
    @design_methods = DesignMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @design_methods }
    end
  end

  def search
    if params[:query]
      search = DesignMethod.search do
        fulltext params[:query]
      end

      @results = search.results
    else
      @results = []
    end
  end

  # GET /design_methods/1
  # GET /design_methods/1.json
  def show
    @design_method = DesignMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @design_method }
    end
  end

  # GET /design_methods/new
  # GET /design_methods/new.json
  def new
    @design_method = DesignMethod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @design_method }
    end
  end

  # GET /design_methods/1/edit
  def edit
    @design_method = DesignMethod.find(params[:id])
  end


  # Creates a DesignMethod.
  def create
    @design_method = DesignMethod.new(params[:design_method])

    respond_to do |format|
      if @design_method.save
        format.html { redirect_to @design_method, notice: 'Design method was successfully created.' }
        format.json { render json: @design_method, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /design_methods/1
  # PUT /design_methods/1.json
  def update
    @design_method = DesignMethod.find(params[:id])

    respond_to do |format|
      if @design_method.update_attributes(params[:design_method])
        format.html { redirect_to @design_method, notice: 'Design method was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /design_methods/1
  # DELETE /design_methods/1.json
  def destroy
    @design_method = DesignMethod.find(params[:id])
    @design_method.destroy

    respond_to do |format|
      format.html { redirect_to design_methods_url }
      format.json { head :no_content }
    end
  end
end
