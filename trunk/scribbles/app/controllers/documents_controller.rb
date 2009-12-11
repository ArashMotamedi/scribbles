class DocumentsController < ApplicationController
  before_filter :get_logged_in_user
  
  # Variables
  # @current_user - The currently logged in user
  # @this_doc - The document that is displayed on the page
  # @doc_account - The account that this document belongs to
  
  def index
    # Get the account of this page
    @doc_account = Account.find_by_name(params[:pagename])
    
    # If this page's account exists, get the default doc for the account
    if @doc_account
      @this_doc = Document.find_by_account_id_and_name(@doc_account.id, DEFAULT_DOC_NAME)
    # Else, create a new temporary account and default doc
    else
      # Method creates a temp account and returns the account and default doc
      @doc_account,@this_doc = create_temp_account(params[:pagename])
    end
  end
  
  def login
    @current_user = Account.find_by_name_and_password(params[:username], params[:password])
    if @current_user
      # Log user in
      session[:user_id] = @current_user.id
    else
      flash.now[:error] = "Wrong username or password"
    end
  end
  
  def logout
    session[:user_id] = @current_user = nil
  end
  
  def Print
  end
  
  def Upload
  end
  
  #### Commands ####
  
  def RetrieveBody
    @body = Document.find(:first, :conditions => {:id => params[:in_doc]}).body
    render :layout => false
  end
  
  def AddComment
    comment = Comment.new(:author => params[:name],
                          :comment => params[:comment],
                          :document_id => params[:in_doc])
    comment.save
    
    redirect_to "documents/Comment"
  end
  
  def RetrieveComments
    @comments = Comment.find(:all,
                            :conditions => {:document_id => params[:in_doc]},
                            :order => "created_at DESC")
    render :layout => false
  end
  
  def RetrieveFiles
    @files = FileTab.find(:all,
                          :conditions => {:document_id => params[:in_doc]},
                          :order => "name")
    render :layout => false
  end
  
  def UploadFile
    upload = params[:upload]
    name = upload['datafile'].original_filename
    directory = "public/files/" + params[:in_doc]
    if not FileTest::directory? directory
      Dir::mkdir directory
    end
    path = File.join(directory, name)
    
    #TODO Check if file already exists
    # Add to DB
    newFile = FileTab.new(:name => name,
                          :path => path,
                          :description => params[:description],
                          :document_id => params[:in_doc])
    newFile.save
    
    # Save file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    redirect_to "/documents/Success"
  end

end
