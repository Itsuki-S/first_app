module ApplicationHelper
  # ページタイトルを返す
  def full_title(page_title = '')
    base_title = "Diver's Log" # 自分のアプリ名
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
