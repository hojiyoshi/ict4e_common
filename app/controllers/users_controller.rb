class UsersController < ApplicationController
  skip_before_filter :login_required
  # 初期化メソッド
  def initialize
    # タイトルの設定
    @title = '：みんなのICT'
    # ナビゲーションタイトルの設定
    @nav_title = "<a href='/users'>ユーザー登録・変更</a> ＞ "
  end
  # ユーザ登録トップ画面
  # user:GET
  def index
    # タイトルの設定
    @title = 'ユーザー登録・変更' + @title
    # ナビゲーションタイトルの設定
    @nav_title = ''
  end

  # ユーザ新規登録画面
  # users/new:GET
  # signup
  def new
    # タイトルの設定
    @title = 'ユーザー登録' + @title

    @user = User.new
  end

  # ユーザ仮登録完了画面
  # users:POST
  def create
    # タイトルの設定
    @title = 'ユーザー登録：仮登録完了' + @title

    logout_keeping_session!
    # Userオブジェクトを作成する。
    @user = User.new(params[:user])

    # バリデーションチェックを行う。
    unless @user.valid?
      # NGの場合
      # タイトルをエラー用にする。
      @title = 'ユーザー登録:エラー' + @title
      # ユーザー登録画面を表示する。
      respond_to do |format|
        format.html{
          render :action => 'new'
        }
      end
      return
    end

    # ユーザーデータをデータベースに登録する。
    success = @user && @user.save
  end

  # ユーザー本登録完了画面
  # user/activate/[activate_code]:GET
  def activate
    # タイトルの設定
    @title = 'ユーザー登録：本登録完了' + @title

    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
    else
      # とりあえず、トップに飛ばす。
      redirect_back_or_default('/')
    end
  end

  # パスワード再発行画面
  # user/forget:GET
  def forget
    # タイトルの設定
    @title = 'パスワードを忘れた方' + @title
  end

  # パスワード再発行メール送信画面
  def send_remind
    ## タイトルの設定
    @title = 'パスワードを忘れた方：再設定のお知らせ' + @title

    # 入力されたメールアドレスのユーザを検索する。
    @user = User.find(
      :first,
      :conditions => ["email = ?  AND activated_at IS NOT NULL", params[:user]['email']])

    # ユーザが存在する場合、再設定メールを送信する。
    unless @user.blank?
      # 認証用コードを取得する。
      @user.activation_code = @user.make_activation_code
      # 認証期限を取得する。
      @user.activated_at = Time.now + 3600
      
      # ユーザデータを更新する。
      @user.save(false)
      # 再設定用URLをメールで送信する
      UserMailer.deliver_remind(@user)
    end
  end

  # パスワード再設定画面
  # user/forget_entry:GET
  def forget_entry
    # タイトルの設定
    @title = 'パスワードの再設定' + @title
    # ナビゲーションタイトルの設定
    @nav_title += "<a href='/users/forget'>パスワードを忘れた方</a> ＞"
    # 認証コードからユーザ情報を取得する
    forget_user = User.find_by_activation_code(params[:id])
    unless forget_user.blank?
      if (forget_user.activated_at.to_i - Time.now.to_i) <= 0
        # 有効期限切れ画面を表示する。
        respond_to do |format|
          format.html{
            render :action => 'forget_expired'
          }
        end
      end
    else
      # トップにリダイレクトさせる。
      redirect_to '/'
    end
  end

  # パスワード再設定完了画面
  # user/forget_entry_send:GET
  def forget_entry_send
    # タイトルの設定
    @title = 'パスワードの再設定' + @title
    # ナビゲーションタイトルの設定
    @nav_title += "<a href='/users/forget'>パスワードを忘れた方</a> ＞"
    
    # 認証コードからユーザ情報を取得する
    @forget_user = User.find_by_activation_code(params[:id])
    @forget_user.password = params[:user]['password']
    # 値チェックを行う。
    if @forget_user.valid?
      # パスワードを暗号化する。
      @forget_user.crypted_password = forget_user.authenticated?(params[:user]['password'])
      # パスワードを更新する。
      @forget_user.save
    else
      respond_to do |format|
        format.html{
          render :action => 'forget_entry'
        }
      end
    end
  end

  # メールアドレス・パスワード変更認証画面
  def edit_auth
    # タイトルの設定
    @title = 'メールアドレス・パスワード変更' + @title
  end

  # メールアドレス・パスワード変更画面
  def edit
    # タイトルの設定
    @title = 'メールアドレス・パスワード変更：編集' + @title
    # ナビゲーションタイトルの設定
    @nav_title += "<a href='/users/edit_auth'>メールアドレス・パスワード変更</a> ＞"

    # 変更対象となるユーザを検索する。
    @user = User.find(params[:id])
  end

  # メールアドレス・パスワード変更完了画面
  def update
    # 変更対象となるユーザを検索する。
    @user = User.find(params[:id])
    # フォームの値をUserオブジェクトに代入する。
    @user.attributes = params[:user]
    # ナビゲーションタイトルの設定
    @nav_title += "<a href='/users/edit_auth'>メールアドレス・パスワード変更</a> ＞"

    # バリデーションチェックNGの場合
    unless @user.valid?
      # タイトルをエラー用にする。
      @title = 'メールアドレス・パスワード変更：編集:エラー' + @title
      # ユーザー登録画面を表示する。
      respond_to do |format|
        format.html{
          render :action => 'edit'
        }
      end
      return
    end
    # タイトルの設定
    @title = 'メールアドレス・パスワード変更：完了' + @title
    # バリデーションチェックOKの場合
    @user.save
  end
end
