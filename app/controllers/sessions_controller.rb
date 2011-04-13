# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  skip_before_filter :login_required

  # render new.erb.html
  #def new
  #  @title = 'ログイン'
  #  if request.env['HTTP_REFERER']
  #    session[:http_referer] = request.env['HTTP_REFERER']
  #  end
  #end

  def create
    logout_keeping_session!
    # 認証処理を行う。
    user = User.authenticate(params[:user][:email], params[:user][:password])
    # 認証OKの場合
    if user
      # Userオブジェクトの値を変数に置く。
      self.current_user = user
      # ユーザ編集画面にリダイレクトさせる。
      redirect_to :controller => 'users', :action => 'edit', :id => user.id
    # 認証NGの場合
    else
      note_failed_signin
      redirect_to :controller => 'users', :action => 'edit_auth'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    # 失敗時のメッセージをflashに保存しておく。（メッセージの表示させないが、値の有無だけ見ている。）
    flash[:error] = 'メールアドレス、またはパスワードが間違っています。'
    # ログファイルに残しておく。
    logger.warn "Failed login for '#{params[:user][:email]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end