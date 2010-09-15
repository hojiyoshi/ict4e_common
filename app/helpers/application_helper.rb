# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ja_error_messages_for(object_name)
    object = instance_variable_get("@#{object_name}")
    unless object.errors.empty?
      render :partial=>"layouts/error_messages_for.html",:locals=>{:messages=>object.errors.full_messages}
    end
  end
end
