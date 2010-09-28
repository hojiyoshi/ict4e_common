# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :login_required

  # render new.erb.html
  def new
    @title = 'ログイン'
    if request.env['HTTP_REFERER']
      session[:http_referer] = request.env['HTTP_REFERER']
    end
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:users][:email], params[:users][:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:users][:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if session[:http_referer]
        redirect_to session[:http_referer]
      else
        redirect_back_or_default('/')
        flash[:notice] = "ログインしました。"
      end
    else
      note_failed_signin
      @login       = params[:users][:email]
      @remember_me = params[:users][:remember_me]
      render :action => 'new'
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
    flash[:error] = 'メールアドレスまたはパスワードが間違っています。'
    logger.warn "Failed login for '#{params[:users][:email]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
