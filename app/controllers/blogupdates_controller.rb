class BlogupdatesController < ApplicationController
  # used for sanitization user's input
  REDACTOR_TAGS = %w(code span div label a br p b i del strike u img video audio
                  iframe object embed param blockquote mark cite small ul ol li
                  hr dl dt dd sup sub big pre code figure figcaption strong em
                  table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)
  REDACTOR_ATTRIBUTES = %w(href)

  before_filter :authenticate_user! 

  def create
  	@project = Project.find(params[:project_id])

    @blogupdate = @project.blogupdates.create!(params[:blogupdate])
    
    if @blogupdate.save
      redirect_to blogs_project_path(@project), notice: "Blog entry created."
    end   
  end


  def index
    if current_user.try(:admin?)
      @blogupdates = Blogupdate.newest.page(params[:page]).per_page(5)
    else
      redirect_to root_url
    end
  end

  def edit
    if current_user == Blogupdate.find(params[:id]).user
      @blogupdate = Blogupdate.find(params[:id])
    else
      redirect_to @blogupdate.project
    end
  end

  def destroy
  	@blogupdate = Blogupdate.find(params[:id])
    @blogupdate.destroy

    if current_user.try(:admin?)
      redirect_to root_url
    else
      redirect_to @blogupdate.project
    end
  end

   def update
    @blogupdate = Blogupdate.find(params[:id])

    respond_to do |format|
      if @blogupdate.update_attributes(params[:blogupdate])
        format.html { redirect_to @blogupdate.project, notice: 'Project was successfully updated.' }  
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blogupdate.errors, status: :unprocessable_entity }
      end
    end
  end

   private

  def sanitize_redactor(orig_input)
    stripped = view_context.strip_tags(orig_text)
    if stripped.present? # this prevents from creating empty comments
      view_context.sanitize(orig_text, tags: REDACTOR_TAGS, attributes: REDACTOR_ATTRIBUTES)
    else
      nil
    end
  end 


end
