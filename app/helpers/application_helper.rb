# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # 指定したapplication_nameにマッチするIct4eMasterDatumオブジェクトを取得するメソッド
  def select_master_data(target,type=:all)
    master_data = Ict4eMasterDatum.find(type,:conditions => ['application_name = ?',target],:order => 'sort_order ASC')
    if type == :all
      return master_data
    else
      return master_data.item_data
    end
  end

  # 改行コードを含む文字列を出力するための変換メソッド
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end
end
