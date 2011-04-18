# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # 改行コードを含む文字列を出力するための変換メソッド
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  def sub_menu_link(text,controller,action)
    if params[:controller] == controller && params[:action] == action
      return '<a>'+text+'</a>'
    else
      return link_to(text,:controller=>controller, :action => action)
    end
  end
end
