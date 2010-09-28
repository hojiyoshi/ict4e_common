class ContactusController < ApplicationController
  skip_before_filter :login_required

  def initialize
    @title = 'お問い合わせ'
    @error_message = [] # エラーメッセージ格納配列
  end

  def index
    redirect_to :action => 'new'
  end
  
  def confirm
    @error_message.push('名前が入力されていません。') if params[:contactus][:name] == ''
    @error_message.push('メールアドレスが入力されていません。') if params[:contactus][:email] == ''
    @error_message.push('本文が入力されていません。') if params[:contactus][:content] == ''

    if @error_message.size != 0 || !params[:back_page].blank?
      @name = params[:contactus][:name]
      @email = params[:contactus][:email]
      @subject = params[:contactus][:subject]
      @content = params[:contactus][:content]
      
      flash[:error] = get_flash_messages(@error_message,'error')
      respond_to do |format|
        format.html{
          render :action => 'new'
        }
      end
    end
  end

  def create
    UserMailer.deliver_contactus(params[:contactus])
  end

end
