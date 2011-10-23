# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # 改行コードを含む文字列を出力するための変換メソッド
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  def sub_menu_link(text,action)
    text_href = '<a>'+text+'</a>'
    if action == 'new'
      return text_href if params[:action] == 'new' || params[:action] == 'create' || params[:action] == 'activate'
    elsif action == 'edit_auth'
      return text_href if params[:action] == 'edit_auth' || params[:action] == 'edit' || params[:action] == 'update'
    elsif action == 'forget'
      return text_href if params[:action] == 'forget' || params[:action] == 'send_remind' || params[:action] == 'forget_entry' || params[:action] == 'forget_entry_send'
    end

    return link_to(text,:controller=>'users', :action => action)
  end

  def sub_menu_selected(action)
    li_selected =' class="selected"'
    if action == 'new'
      return li_selected if params[:action] == 'new' || params[:action] == 'create' || params[:action] == 'activate'
    elsif action == 'edit_auth'
      return li_selected if params[:action] == 'edit_auth' || params[:action] == 'edit' || params[:action] == 'update'
    elsif action == 'forget'
      return li_selected if params[:action] == 'forget' || params[:action] == 'send_remind' || params[:action] == 'forget_entry' || params[:action] == 'forget_entry_send'
    end
  end

  def get_protcol_type
    return request.protocol
  end
end
