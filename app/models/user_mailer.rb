class UserMailer < ActionMailer::Base
  require 'net/pop'
  require 'kconv'
  require 'nkf'

  def signup_notification(user)
    setup_email(user)
    @subject    += NKF.nkf('-j --cp932 -m0',"ユーザ登録申請手続きのお知らせ")
    @body[:url]  = @body[:server_name] +"activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += NKF.nkf('-j --cp932 -m0',"ユーザ登録完了のお知らせ")
    @body[:url]  = @body[:server_name]
  end

  def remind(user)
    setup_email(user)
    @body[:url]  = @body[:server_name]+"users/forget_entry/" + user.activation_code
    @subject    += NKF.nkf('-j --cp932 -m0','パスワード再設定URLのお知らせ')
  end

  ### メール本文の文字コードを変換するメソッド
  def create! (*)
    super
    @mail.body = NKF.nkf('-j --cp932 -m0',@mail.body)
    return @mail
  end
  
  protected
    def setup_email(user = nil)
      @body[:office] = OFFICE_EMAIL                             # 問い合わせ先のメールアドレス（環境に合わせる）
      @body[:server_name] = ICT4E_ACCOUNTS_URL                  # config/environment.rb参照
      @body[:ict4everyone_name] = ICT4E_URL                     # みんなのICTのURL
      @mime_version = '1.0'                                     # mime version
      @charset      = 'iso-2022-jp'                             # 文字コード
      @content_type = 'text/plain'                              # content_type
      @subject      = NKF.nkf('-j --cp932 -m0',"【みんなのICT】")# 件名
      @from         = 'ict4e-info@ict4everyone.jp'              # 送信元
      @sent_on      = Time.now                                  # 送信時刻
      @headers      = {'Content-Transfer-Encoding' => '7bit'}   # 送信ヘッダ
      unless user == nil
        @recipients   = "#{user.email}"                           # 宛先
        @body[:user]  = user                                      # 本文
      else
        @recipients   = 'hojiyoshi@gmail.com'  
      end
    end
end
