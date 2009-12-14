module DocumentsHelper
  # Constant to store all icons
  ICONS = []
  
  # icon types (first element is the name of the icon file that we use, e.g. doc.gif)
  ICONS << ["image", "jpg", "jpeg", "gif", "png"]
  ICONS << ["doc", "docx"]
  ICONS << ["video", "avi", "mov", "mpg", "mpeg"]
  ICONS << ["pdf"]
  
  # Returns the correct icon to use, given a file extension
  def get_icon(extension)
    ICONS.each do |ext_type|
      # Compare the extension to each value in the list
      ext_type.each do |value|
        if extension == value
          return ext_type[0]
        end
      end
    end
    
    # If extension doesn"t match anything on the list, return default
    return "default"
  end
end
