# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def set_page_title(str="")
    if not str.blank?
      content_for :page_title do
        " - #{str}"
      end
    end
  end
end
