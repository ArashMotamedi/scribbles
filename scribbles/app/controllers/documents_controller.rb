class DocumentsController < ApplicationController
  before_filter :get_logged_in_user
  helper DocumentsHelper
  
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
    @current_user = Account.authenticate(params[:username], params[:password])
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
  
  def Body
    render :layout => false
  end
  
  def Comment
    render :layout => false
  end
  
  def Password
    render :layout => false
  end
  
  def Upload
  end
  
  #### Commands ####
  
  def RetrieveBody
    doc = Document.find(:first, :conditions => {:id => params[:in_doc]})
    @body = doc.body
	@lock_holder = doc.lock_holder
    render :layout => false
  end
  
  def UpdateBody
    # Get the existing document
    doc = Document.find(:first, :conditions => {:id => params[:in_doc]})
    doc.update_attribute(:body, params[:documentBody])
    redirect_to "/documents/Body"
  end
  
  def RetrieveComments
    @comments = Comment.find(:all,
                            :conditions => {:document_id => params[:in_doc]},
                            :order => "created_at DESC")
    render :layout => false
  end
  
  def AddComment
    comment = Comment.new(:author => params[:name],
                          :comment => params[:comment],
                          :document_id => params[:in_doc])
    comment.save
    
    redirect_to "/documents/Comment"
  end
  
  def RetrieveFiles
    @files = FileTab.find(:all,
                          :conditions => {:document_id => params[:in_doc]},
                          :order => "updated_at DESC")
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
    
    # Check if file already exists
    file = FileTab.find(:first, :conditions => {:document_id => params[:in_doc],
                                                :name => name})

    # If file exists, update the record
    if file
      file.update_attribute(:description, params[:description])
    # Else, if file doesn't exist, add new record
    else
      # Add to DB
      file = FileTab.new(:name => name,
                         :path => path,
                         :description => params[:description],
                         :document_id => params[:in_doc])
      file.save
    end
    
    # Save file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    redirect_to "/documents/Success"
  end
  
  def AcquireLock
    # Get the document and lock
    doc = Document.find(:first, :conditions => {:id => params[:in_doc]})
    lock = doc.lock_holder
    
    # If lock is not held, then print 'Lock yours'
    if lock == ""
      @message = "Lock yours"
      
      # Assign user's name to lock
      if @current_user
        doc.update_attribute(:lock_holder, @current_user.name)
      else
        doc.update_attribute(:lock_holder, "Another person")
      end
    # Else, lock is held, so print the user holding the lock
    else
      @message = lock
    end
  
    render :layout => false
  end
  
  def ReleaseLock
    doc = Document.find(:first, :conditions => {:id => params[:in_doc]})
    doc.update_attribute(:lock_holder, "")
    render :layout => false
  end
  
  def SetPassword
    # Get the document and set password
    doc = Document.find(:first, :conditions => {:id => params[:in_doc]})
    doc.update_attribute(:password, params[:password])
    redirect_to "/documents/Password"
  end

end
